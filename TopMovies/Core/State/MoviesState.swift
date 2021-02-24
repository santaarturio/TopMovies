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
      return MoviesState(relational: movies.hashMap(into: state.relational, id: \.id))
    case let action as CompletedMovieCategoriesAction:
      return MoviesState(relational: state.relational
                          .merging(action.moviesRelational)
                            { $1 })
    case let action as CompletedMoviesListAction:
      return MoviesState(relational: action.list.hashMap(into: state.relational, id: \.id))
    default: return state
    }
  }
}
