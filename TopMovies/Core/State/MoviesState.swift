//
//  MoviesState.swift
//  TopMovies
//
//  Created by anikolaenko on 11.02.2021.
//

import ReSwift

typealias PreviewsRelational = [MoviePreview.ID: MoviePreview]
typealias MoviesRelational = [MoviePreview.ID: Movie]

struct MoviesState: StateType {
  let previewsRelational: PreviewsRelational
  let moviesRelational: MoviesRelational
}

extension MoviesState {
  static func reduce(action: Action, state: MoviesState) -> MoviesState {
    switch action {
    case let action as CompletedMovieCategoriesAction:
      let movies = updatedMovies(state.moviesRelational,
                                 previews: Array(action.previewsRelational.values))
      return MoviesState(
        previewsRelational: state.previewsRelational.merging(action.previewsRelational) { $1 },
        moviesRelational: movies.hashMap(into: state.moviesRelational, id: \.id)
      )
    case let action as CompletedPreviewsListAction:
      let movies = updatedMovies(state.moviesRelational,
                                 previews: action.list)
      return MoviesState(
        previewsRelational: action.list.hashMap(into: state.previewsRelational, id: \.id),
        moviesRelational: movies.hashMap(into: state.moviesRelational, id: \.id)
      )
    case let action as CompletedMovieUpdateAction:
      let moviePreview = MoviePreview(id: action.movie.id,
                                      adult: action.movie.adult,
                                      title: action.movie.title,
                                      description: action.movie.description,
                                      rating: action.movie.rating,
                                      voteCount: action.movie.voteCount,
                                      releaseDate: action.movie.releaseDate,
                                      poster: action.movie.poster)
      return MoviesState(
        previewsRelational: [moviePreview].hashMap(into: state.previewsRelational, id: \.id),
        moviesRelational: [action.movie].hashMap(into: state.moviesRelational, id: \.id)
      )
    default: return state
    }
  }
  private static func updatedMovies(_ movies: MoviesRelational, previews: [MoviePreview]) -> [Movie] {
    previews.compactMap { preview -> Movie? in
      guard let movie = movies[preview.id] else { return nil }
      return Movie(id: preview.id,
                   adult: preview.adult,
                   title: preview.title,
                   description: preview.description,
                   budget: movie.budget,
                   genres: movie.genres,
                   productionCompanies: movie.productionCompanies,
                   rating: preview.rating,
                   voteCount: preview.voteCount,
                   releaseDate: preview.releaseDate,
                   status: movie.status,
                   poster: preview.poster)
    }
  }
}
