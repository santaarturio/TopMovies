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
        case let .success(categorieList):
          mainStore.dispatch(MovieCategoriesAction
                              .completed(categories: [MovieCategory(dto: categorieList)]))
        case let .failure(error):
          mainStore.dispatch(MovieCategoriesAction.failed(error: error))
        }
      }
    default: break
    }
  }
}
