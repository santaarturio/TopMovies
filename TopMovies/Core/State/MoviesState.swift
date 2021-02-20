//
//  MoviesState.swift
//  TopMovies
//
//  Created by anikolaenko on 11.02.2021.
//

import ReSwift

struct MoviesState: StateType {
  let relational: [Movie.ID: Movie]
}

extension MoviesState {
  static func reduce(action: Action, state: MoviesState) -> MoviesState {
    switch action {
    case let responseAction as MovieCategoriesAction:
      return reduceIfMovieCategoriesAction(action: responseAction, state: state)
    case let responseAction as MoviesResponseAction:
      return reduceIfMoviesResponseAction(action: responseAction, state: state)
    default: return state
    }
  }
  
  // MARK: - MovieCategoriesAction
  private static func reduceIfMovieCategoriesAction(action: MovieCategoriesAction, state: MoviesState) -> MoviesState {
    switch action {
    case let .completed(_, movies, _):
      return MoviesState(relational: movies.hashMap(into: state.relational, id: \.id))
    default: return state
    }
  }
  // MARK: - MoviesResponseAction
  private static func reduceIfMoviesResponseAction(action: MoviesResponseAction, state: MoviesState) -> MoviesState {
    switch action.responseType {
    case .completed:
      return MoviesState(relational: state.relational.merging(action.list.hashMap(id: \.id)) { $1 })
    default: return state
    }
  }
}
