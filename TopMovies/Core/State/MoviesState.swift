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
    case let PreviewsDownloadingAction.completed(_, previews):
      return MoviesState(previewsRelational: previews.hashMap(into: state.previewsRelational, id: \.id),
                         moviesRelational: state.moviesRelational)
    case let action as CompletedMovieCategoriesAction:
      return MoviesState(previewsRelational: state.previewsRelational
                          .merging(action.previewsRelational) { $1 },
                         moviesRelational: state.moviesRelational)
    case let action as CompletedPreviewsListAction:
      return MoviesState(previewsRelational: action.list.hashMap(into: state.previewsRelational, id: \.id),
                         moviesRelational: state.moviesRelational)
    default: return state
    }
  }
}

/*
 struct MoviesState {
 let moviesRelational: [Movie.ID: Movie]
 let previewsRelational: [Movie.ID: MoviePreview]
 
 static func reduce(state: MoviesState, event: Action) -> MoviesState {
 switch event {
 case let event as CompleteMovieUpdate:
 let moviePreview = MoviePreview(id: event.movie.id, title: event.movie.title)
 return MoviesState(
 moviesRelational: [event.movie].hashMap(into: state.previewsRelational, by: \.id),
 previewsRelational: [moviePreview].hashMap(into: state.previewsRelational, by: \.id)
 )
 
 case let event as CompleteMoviesDownloading:
 let movies = event.movies.compactMap { preview -> Movie? in
 guard let movie = state.moviesRelational[preview.id] else { return nil }
 return Movie(
 id: preview.id,
 title: preview.title,
 poster: movie.poster,
 rating: movie.rating
 )
 }
 return MoviesState(
 moviesRelational: movies.hashMap(into: state.previewsRelational, by: \.id),
 previewsRelational: event.movies.hashMap(into: state.previewsRelational, by: \.id)
 )
 default:
 return state
 }
 }
 }
 */
