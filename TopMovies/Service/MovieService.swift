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
    switch state.movieCategoriesState.categoriesList {
    case .requested:
      mainStore.dispatch(MovieCategoriesAction.downloading)
      movieAPI.allMovieCategories { result in
        switch result {
        case let .success(categoriesList):
          categoriesList
            .map { MoviesDownloadingAction
              .completed(MovieCategory(dto: $0).id,
                         $0.results.map { Movie(dto: $0) })}
            .forEach(mainStore.dispatch)
          mainStore.dispatch(MovieCategoriesAction
                              .completed(categories: categoriesList.map { MovieCategory(dto: $0) }))
        case let .failure(error):
          mainStore.dispatch(MovieCategoriesAction.failed(error: error))
        }
      }
    default: break
    }
    state.categoryRequestsState.categoryRequests.forEach { categoryID, requestState in
      switch requestState {
      case .requested:
        mainStore.dispatch(MoviesDownloadingAction.downloading(category: categoryID))
        movieAPI.category(with: CategoryNameCoder.decodeTarget(from: categoryID.value) ?? .nowPlaying())
        { (result) in
          switch result {
          case let .success(categoryDTO):
            mainStore.dispatch(MoviesDownloadingAction.completed(categoryID,
                                                                 categoryDTO.results.map { Movie(dto: $0) }))
          case let .failure(error):
            mainStore.dispatch(MoviesDownloadingAction.failed(categoryID, error))
          }
        }
      default: break
      }
    }
  }
}
