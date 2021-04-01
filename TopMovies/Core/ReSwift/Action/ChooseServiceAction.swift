//
//  ChooseServiceAction.swift
//  TopMovies
//
//  Created by Macbook Pro  on 09.04.2021.
//

import ReSwift

enum StreamingService {
  case tmdb
  case quintero
}

struct ChooseServiceAction: Action {
  let service: StreamingService
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
