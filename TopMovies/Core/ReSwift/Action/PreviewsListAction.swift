//
//  PreviewsListAction.swift
//  TopMovies
//
//  Created by Macbook Pro  on 21.02.2021.
//

import ReSwift

enum RequestType { case reload, loadMore }

struct RequestedPreviewsListAction: Action {
  let categoryId: MovieCategory.ID
  let requestType: RequestType
}
struct DownloadingPreviewsListAction: Action {
  let categoryId: MovieCategory.ID
  let requestType: RequestType
}
struct CompletedPreviewsListAction: Action {
  let categoryId: MovieCategory.ID
  let requestType: RequestType
  let list: [MoviePreview]
  let nextPage: String?
}
struct FailedPreviewsListAction: Action {
  let categoryId: MovieCategory.ID
  let requestType: RequestType
  let error: Error
}
