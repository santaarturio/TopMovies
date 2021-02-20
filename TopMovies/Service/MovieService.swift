//
//  MovieService.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import Foundation
import ReSwift

class MovieService: StoreSubscriber {
  static let shared = MovieService(movieAPI: MovieAPI())
  typealias StoreSubscriberStateType = MainState
  
  private let movieAPI: MovieAPIProtocol
  
  init(movieAPI: MovieAPIProtocol) {
    self.movieAPI = movieAPI
    mainStore.subscribe(self)
  }
  
  func newState(state: MainState) {
    requestAllCategoriesIfNeeded(state: state.movieCategoriesState)
    requestSomeCategoryIfNeeded(state: state.paginationState)
  }
  
  private func requestAllCategoriesIfNeeded(state: MovieCategoriesState) {
    if state.categoriesList.isRequested {
      mainStore.dispatch(MovieCategoriesAction.downloading)
      movieAPI.allMovieCategories { result in
        switch result {
        case let .success(categoriesList):
          mainStore.dispatch(MovieCategoriesAction
                              .completed(
                                categories: categoriesList.map { MovieCategory(dto: $0) },
                                movies: categoriesList
                                  .map { $0.results.map { Movie(dto: $0) } }
                                  .flatMap { $0 },
                                relational: categoriesList
                                  .reduce(into: [:]) { dict, categoryDTO in
                                    dict[MovieCategory.ID(value: categoryDTO.id)]
                                      = categoryDTO.results
                                      .map { Movie.ID(value: String($0.id)) }
                                  }))
        case let .failure(error):
          mainStore.dispatch(MovieCategoriesAction.failed(error: error))
        }
      }
    }
  }
  
  private func requestSomeCategoryIfNeeded(state: PaginationState) {
    state.paginated.forEach { categoryID, paginatedState in
      guard let categoryRequest = MovieCategoryRequest.init(rawValue: categoryID.value) else { return }
      if case EmptyRequestState.requested = paginatedState.loadMore,
         case let PaginationState.CategoryState.PageInfo.next(requestedPage) = paginatedState.pageInfo {
        mainStore.dispatch(MoviesResponseAction(categoryId: categoryID,
                                                list: [],
                                                requestedType: .loadMore,
                                                responseType: .downloading,
                                                nextPage: nil))
        movieAPI.category(categoryRequest, page: requestedPage) { (result) in
          switch result {
          case let .success(categoryDTO):
            mainStore.dispatch(MoviesResponseAction(categoryId: categoryID,
                                                    list: categoryDTO.results.map { Movie(dto: $0) },
                                                    requestedType: .loadMore,
                                                    responseType: .completed,
                                                    nextPage: categoryDTO.nextPage))
          case let .failure(error):
            mainStore.dispatch(MoviesResponseAction(categoryId: categoryID,
                                                    list: [],
                                                    requestedType: .loadMore,
                                                    responseType: .failed(error: error),
                                                    nextPage: nil))
          }
        }
      } else if case EmptyRequestState.requested = paginatedState.reload {
        mainStore.dispatch(MoviesResponseAction(categoryId: categoryID,
                                                list: [],
                                                requestedType: .reload,
                                                responseType: .downloading,
                                                nextPage: nil))
        movieAPI.category(categoryRequest, page: 1) { (result) in
          switch result {
          case let .success(categoryDTO):
            mainStore.dispatch(MoviesResponseAction(categoryId: categoryID,
                                                    list: categoryDTO.results.map { Movie(dto: $0) },
                                                    requestedType: .reload,
                                                    responseType: .completed,
                                                    nextPage: categoryDTO.nextPage))
          case let .failure(error):
            mainStore.dispatch(MoviesResponseAction(categoryId: categoryID,
                                                    list: [],
                                                    requestedType: .reload,
                                                    responseType: .failed(error: error),
                                                    nextPage: nil))
          }
        }
      }
    }
  }
}

extension CategoryDTO {
  var nextPage: Int? { page < totalPages ? page + 1 : nil }
}
