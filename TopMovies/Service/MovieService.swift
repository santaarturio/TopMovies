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
    requestMoviesUpdateIfNeeded(state: state.moviesUpdateState, moviesRelational: state.moviesState.moviesRelational)
  }
  
  private func requestAllCategoriesIfNeeded(state: MovieCategoriesState) {
    if state.categoriesList.isRequested {
      provider.dispatch(DownloadingMovieCategoriesAction())
      movieAPI.allMovieCategories(callBackQueue: serviceQueue) { [unowned self] result in
        switch result {
        case let .success(categoriesList):
          provider.dispatch(CompletedMovieCategoriesAction(
                              categories: categoriesList.map { MovieCategoryWrapper(category: .init(dto: $0),
                                                                                    next: $0.next) },
                              previewsRelational: categoriesList
                                .map { $0.movies.map(MoviePreview.init(dto:)) }
                                .flatMap { $0 }
                                .hashMap(into: PreviewsRelational(), id: \.id),
                              relational: categoriesList
                                .reduce(into: [:]) { dict, categoryDTO in
                                  dict[MovieCategory.ID(value: categoryDTO.id)]
                                    = categoryDTO.movies
                                    .map(\.id)
                                    .map(String.init)
                                    .map(MoviePreview.ID.init(value:))
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
        provider.dispatch(DownloadingPreviewsListAction(categoryId: categoryId,
                                                        requestType: .loadMore))
        movieAPI.category(request: categoryRequest,
                          page: requestedPage) { [unowned self] result in
          switch result {
          case let .success(categoryDTO):
            provider.dispatch(CompletedPreviewsListAction(categoryId: categoryId,
                                                          requestType: .loadMore,
                                                          list: categoryDTO.movies
                                                            .map(MoviePreview.init(dto:)),
                                                          nextPage: categoryDTO.next))
          case let .failure(error):
            provider.dispatch(FailedPreviewsListAction(categoryId: categoryId,
                                                       requestType: .loadMore,
                                                       error: error))
          }
        }
      } else if case .requested = paginatedState.reload {
        provider.dispatch(DownloadingPreviewsListAction(categoryId: categoryId,
                                                        requestType: .reload))
        movieAPI.category(request: categoryRequest,
                          page: nil) { [unowned self] result in
          switch result {
          case let .success(categoryDTO):
            provider.dispatch(CompletedPreviewsListAction(categoryId: categoryId,
                                                          requestType: .reload,
                                                          list: categoryDTO.movies
                                                            .map(MoviePreview.init(dto:)),
                                                          nextPage: categoryDTO.next))
          case let .failure(error):
            provider.dispatch(FailedPreviewsListAction(categoryId: categoryId,
                                                       requestType: .reload,
                                                       error: error))
          }
        }
      }
    }
  }
  
  private func requestMoviesUpdateIfNeeded(state: MoviesUpdateState, moviesRelational: MoviesRelational) {
    state.relational.forEach { movieId, updateState in
      if moviesRelational[movieId] != nil { return }
      if updateState.isRequested {
        provider.dispatch(DownloadingMovieUpdateAction(movieId: movieId))
        movieAPI.movie(id: movieId) { [unowned self] result in
          switch result {
          case let .success(movieDTO):
            provider.dispatch(CompletedMovieUpdateAction(movie: .init(dto: movieDTO)))
          case let .failure(error):
            provider.dispatch(FailedMovieUpdateAction(movieId: movieId, error: error))
          }
        }
      }
    }
  }
}
