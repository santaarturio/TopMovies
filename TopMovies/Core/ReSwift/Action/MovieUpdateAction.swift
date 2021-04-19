//
//  MovieUpdateAction.swift
//  TopMovies
//
//  Created by Macbook Pro  on 23.03.2021.
//

import ReSwift

struct RequestMovieUpdateAction: ANAction {
  let movieId: MoviePreview.ID
}
struct DownloadingMovieUpdateAction: ANAction {
  let movieId: MoviePreview.ID
}
struct CompletedMovieUpdateAction: ANAction {
  let movie: Movie
}
struct FailedMovieUpdateAction: ANAction {
  let movieId: MoviePreview.ID
  let error: Error
}
