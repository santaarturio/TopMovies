//
//  MovieService.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

final class MovieService<Provider: StoreProviderProtocol>: BaseService<Provider>
where Provider.ExpectedStateType == MainState {
  private let movieAPI: MovieAPIProtocol
  
  typealias StateUpdate = (MainState) -> Void
  init(movieAPI: MovieAPIProtocol, storeProvider: (@escaping StateUpdate) -> Provider) {
    self.movieAPI = movieAPI
    super.init(provider: storeProvider)
  }
  
  override func newState(state: MainState) {
    requestAllCategoriesIfNeeded(state: state.movieCategoriesState)
    requestSomeCategoryIfNeeded(state: state.categoriesPaginationState)
  }
  
  private func requestAllCategoriesIfNeeded(state: MovieCategoriesState) {
    if state.categoriesList.isRequested {
      provider.dispatch(DownloadingMovieCategoriesAction())
      movieAPI.allMovieCategories { [unowned self] result in
        switch result {
        case let .success(categoriesList):
          provider.dispatch(CompletedMovieCategoriesAction(
                              categories: categoriesList.map(MovieCategory.init(dto:)),
                              moviesRelational: categoriesList
                                .map { $0.results.map(Movie.init(dto:)) }
                                .flatMap { $0 }
                                .hashMap(into: MoviesRelational(), id: \.id),
                              relational: categoriesList
                                .reduce(into: [:]) { dict, categoryDTO in
                                  dict[MovieCategory.ID(value: categoryDTO.name)]
                                    = categoryDTO.results
                                    .map(\.id)
                                    .map(String.init)
                                    .map(Movie.ID.init(value:))
                                }))
        case let .failure(error):
          provider.dispatch(FailedMovieCategoriesAction(error: error))
        }
      }
    }
  }
  
  private func requestSomeCategoryIfNeeded(state: CategoriesPaginationState) {
    state.paginated.forEach { categoryId, paginatedState in
      guard let categoryRequest = MovieCategoryRequest.init(rawValue: categoryId.value) else { return }
      if case .requested = paginatedState.loadMore,
         case let CategoriesPaginationState.CategoryState.PageInfo
          .next(requestedPage) = paginatedState.pageInfo {
        provider.dispatch(DownloadingMoviesListAction(categoryId: categoryId,
                                                      requestType: .loadMore))
        movieAPI.category(categoryRequest, page: requestedPage) { [unowned self] result in
          switch result {
          case let .success(categoryDTO):
            provider.dispatch(CompletedMoviesListAction(categoryId: categoryId,
                                                        requestType: .loadMore,
                                                        list: categoryDTO.results
                                                          .map(Movie.init(dto:)),
                                                        nextPage: categoryDTO.nextPage))
          case let .failure(error):
            provider.dispatch(FailedMoviesListAction(categoryId: categoryId,
                                                     requestType: .loadMore,
                                                     error: error))
          }
        }
      } else if case .requested = paginatedState.reload {
        provider.dispatch(DownloadingMoviesListAction(categoryId: categoryId,
                                                      requestType: .reload))
        movieAPI.category(categoryRequest, page: 1) { [unowned self] result in
          switch result {
          case let .success(categoryDTO):
            provider.dispatch(CompletedMoviesListAction(categoryId: categoryId,
                                                        requestType: .reload,
                                                        list: categoryDTO.results
                                                          .map(Movie.init(dto:)),
                                                        nextPage: categoryDTO.nextPage))
          case let .failure(error):
            provider.dispatch(FailedMoviesListAction(categoryId: categoryId,
                                                     requestType: .reload,
                                                     error: error))
          }
        }
      }
    }
  }
}
