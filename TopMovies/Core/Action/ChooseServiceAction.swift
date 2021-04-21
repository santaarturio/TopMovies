//
//  ChooseServiceAction.swift
//  TopMovies
//
//  Created by Macbook Pro  on 09.04.2021.
//

enum StreamingService: String {
  case tmdb
  case quintero
}

struct ChooseServiceAction: ANAction {
  let service: StreamingService
}

extension MoviesServiceState {
  init(service: StreamingService) {
    switch service {
    case .quintero: self = .quintero
    case .tmdb: self = .tmdb
    }
  }
}

extension StreamingService {
  init?(state: MoviesServiceState) {
    switch state {
    case .quintero: self = .quintero
    case .tmdb: self = .tmdb
    default: return nil
    }
  }
}