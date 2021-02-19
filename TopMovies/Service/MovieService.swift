//
//  MovieService.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import Foundation
import ReSwift

class MovieService: StoreSubscriber {
  typealias StoreSubscriberStateType = MainState
  
  private let movieAPI: MovieAPIProtocol
  
  init(movieAPI: MovieAPIProtocol) {
    self.movieAPI = movieAPI
    mainStore.subscribe(self)
  }
  
  func newState(state: MainState) {
    requestAllCategoriesIfNeeded(state: state.movieCategoriesState)
    requestSomeCategoryIfNeeded(state: state.categoryRequestsState)
  }
  
  private func requestAllCategoriesIfNeeded(state: MovieCategoriesState) {
    if state.categoriesList.isRequested {
      mainStore.dispatch(MovieCategoriesAction.downloading)
      movieAPI.allMovieCategories { result in
        switch result {
        case let .success(categoriesList):
          categoriesList
            .map { MoviesDownloadingAction
              .completed(MovieCategory(dto: $0),
                         $0.results.map { Movie(dto: $0) })}
            .forEach(mainStore.dispatch)
          mainStore.dispatch(MovieCategoriesAction
                              .completed(categories: categoriesList.map { MovieCategory(dto: $0) }))
        case let .failure(error):
          mainStore.dispatch(MovieCategoriesAction.failed(error: error))
        }
      }
    }
  }
  
  private func requestSomeCategoryIfNeeded(state: CategoryRequestsState) {
    state.categoryRequests.forEach { categoryID, requestState in
      guard
        requestState.isRequested,
        let categoryRequest = MovieCategoryRequest.init(rawValue: categoryID.value),
        let requestedPage = state.requestedPages[categoryID]?.next
      else { return }
      mainStore.dispatch(MoviesDownloadingAction.downloading(category: categoryID))
      movieAPI.category(categoryRequest, page: requestedPage) { (result) in
        switch result {
        case let .success(categoryDTO):
          mainStore.dispatch(MoviesDownloadingAction.completed(MovieCategory(dto: categoryDTO),
                                                               categoryDTO.results.map { Movie(dto: $0) }))
        case let .failure(error):
          mainStore.dispatch(MoviesDownloadingAction.failed(categoryID, error))
        }
      }
    }
  }
}
