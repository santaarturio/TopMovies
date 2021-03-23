//
//  PreviewsDownloadingAction.swift
//  TopMovies
//
//  Created by anikolaenko on 11.02.2021.
//

import ReSwift

enum PreviewsDownloadingAction: Action {
  case requestFor(category: MovieCategory.ID)
  case downloading(category: MovieCategory.ID)
  case completed(MovieCategory, [MoviePreview])
  case failed(MovieCategory.ID, Error)
}
