//
//  MovieCategoriesAction.swift
//  TopMovies
//
//  Created by anikolaenko on 11.02.2021.
//

import ReSwift

struct RequestMovieCategoriesAction: Action { }
struct DownloadingMovieCategoriesAction: Action { }
struct CompletedMovieCategoriesAction: Action {
  let categories: [MovieCategory]
  let previewsRelational: [MoviePreview.ID: MoviePreview]
  let relational: [MovieCategory.ID: [MoviePreview.ID]]
}
struct FailedMovieCategoriesAction: Action {
  let error: Error
}
