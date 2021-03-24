//
//  MoviesUpdateState.swift
//  TopMovies
//
//  Created by Macbook Pro  on 24.03.2021.
//

import ReSwift

struct MoviesUpdateState {
  let relational: [MoviePreview.ID: UpdateRequestState]
}

extension MoviesUpdateState {
  static func reduce(action: Action, state: MoviesUpdateState) -> MoviesUpdateState {
    var relational = state.relational
    switch action {
    case let action as RequestMovieUpdateAction:
      relational.updateValue(.requested, forKey: action.movieId)
      return MoviesUpdateState(relational: relational)
    case let action as DownloadingMovieUpdateAction:
      relational.updateValue(.downloading, forKey: action.movieId)
      return MoviesUpdateState(relational: relational)
    case let action as CompletedMovieUpdateAction:
      relational.updateValue(.updated, forKey: action.movie.id)
      return MoviesUpdateState(relational: relational)
    case let action as FailedMovieUpdateAction:
      relational.updateValue(.failed(action.error), forKey: action.movieId)
      return MoviesUpdateState(relational: relational)
    default: return state
    }
  }
}
