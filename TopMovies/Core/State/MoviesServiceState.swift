//
//  MoviesServiceState.swift
//  TopMovies
//
//  Created by Macbook Pro  on 10.04.2021.
//

import ReSwift

enum MoviesServiceState: StateType, AutoEnum {
  case initial
  case tmdb
  case quintero
}

extension MoviesServiceState {
  static func reduce(action: Action, state: MoviesServiceState) -> MoviesServiceState {
    guard let action = action as? ChooseServiceAction else { return state }
    
    switch action.service {
    case .tmdb:
      return .tmdb
    case .quintero:
      return .quintero
    }
  }
}
