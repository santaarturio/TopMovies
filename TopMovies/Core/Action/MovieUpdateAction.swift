//
//  MovieUpdateAction.swift
//  TopMovies
//
//  Created by Macbook Pro  on 23.03.2021.
//

import ReSwift

struct RequestMovieUpdateAction: Action {
  let movieId: MoviePreview.ID
}
struct DownloadingMovieUpdateAction: Action {
  let movieId: MoviePreview.ID
}
struct CompletedMovieUpdateAction: Action {
  let movie: Movie
}
struct FailedMovieUpdateAction: Action {
  let movieId: MoviePreview.ID
  let error: Error
}
