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
    case let MoviesDownloadingAction.completed(_, movies):
      return MoviesState(relational: state.relational
                          .merging(
                            movies.reduce(into: MoviesRelational()) { dict, movie in
                              dict[movie.id] = movie
                            }) { $1 })
    default: return state
    }
  }
}
