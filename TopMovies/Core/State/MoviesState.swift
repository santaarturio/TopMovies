//
//  MoviesState.swift
//  TopMovies
//
//  Created by anikolaenko on 11.02.2021.
//

import ReSwift

typealias MoviesRelational = [Movie.ID: Movie]

struct MoviesState: StateType {
  let relational: MoviesRelational
}

extension MoviesState {
  static func reduce(action: Action, state: MoviesState) -> MoviesState {
    switch action {
    case let MovieCategoriesAction.completed(categories):
      var relational = MoviesRelational()
      categories.forEach{ $0.movies
        .forEach{ relational[$0.id] = $0 } }
      return MoviesState(relational: relational)
    case let MoviesDownloadingAction.completed(_, movies):
      var relational = state.relational
      movies.forEach{ relational[$0.id] = $0 }
      return MoviesState(relational: relational)
    default: return state
    }
  }
}
