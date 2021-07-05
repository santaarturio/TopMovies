//
//  MovieCategoriesAction.swift
//  TopMovies
//
//  Created by anikolaenko on 11.02.2021.
//

struct RequestMovieCategoriesAction: ANAction { }
struct DownloadingMovieCategoriesAction: ANAction { }
struct CompletedMovieCategoriesAction: ANAction {
  let categories: [MovieCategoryWrapper]
  let previewsRelational: [MoviePreview.ID: MoviePreview]
  let relational: [MovieCategory.ID: [MoviePreview.ID]]
}
struct FailedMovieCategoriesAction: ANAction {
  let error: Error
}
