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
      movieAPI.topMovies { (result) in
        switch result {
        case let .success(categoriesList) where !categoriesList.isEmpty:
          mainStore.dispatch(MovieCategoriesAction
                              .completed(categories: categoriesList.map { MovieCategory(dto: $0) }))
          categoriesList.first.map { category in
            MoviesDownloadingAction.completed(
              MovieCategory.ID(value: String(category.id)),
              category.results.map { Movie(dto: $0) }
            )
          }.map(mainStore.dispatch)
        case let .failure(error):
          mainStore.dispatch(MovieCategoriesAction.failed(error: error))
        default: break
        }
      }
    default: break
    }
  }
}
