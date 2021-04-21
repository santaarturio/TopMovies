//
//  MoviesServiceState.swift
//  TopMovies
//
//  Created by Macbook Pro  on 10.04.2021.
//

import ReSwift

enum MoviesServiceState: StateType {
  case initial
  case tmdb
  case quintero
}

extension MoviesServiceState: ANState {
  static var defaultValue: MoviesServiceState = .initial
}

extension MoviesServiceState {
  static func reduce(action: ANAction, state: MoviesServiceState) -> MoviesServiceState {
    guard let action = action as? ChooseServiceAction else { return state }
    
    switch action.service {
    case .tmdb:
      return .tmdb
    case .quintero:
      return .quintero
    }
  }
}
