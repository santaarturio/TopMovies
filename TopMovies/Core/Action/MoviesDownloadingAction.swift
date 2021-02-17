//
//  MoviesDownloadingAction.swift
//  TopMovies
//
//  Created by anikolaenko on 11.02.2021.
//

import ReSwift

enum MoviesDownloadingAction: Action {
  case requestFor(category: MovieCategory.ID)
  case downloading(category: MovieCategory.ID)
  case completed(MovieCategory, [Movie])
  case failed(MovieCategory.ID, Error)
  case allMoviesDownloaded
}
