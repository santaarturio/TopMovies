//
//  PreviewsListAction.swift
//  TopMovies
//
//  Created by Macbook Pro  on 21.02.2021.
//

import ReSwift

enum RequestType { case reload, loadMore }

struct RequestedPreviewsListAction: ANAction {
  let categoryId: MovieCategory.ID
  let requestType: RequestType
}
struct DownloadingPreviewsListAction: ANAction {
  let categoryId: MovieCategory.ID
  let requestType: RequestType
}
struct CompletedPreviewsListAction: ANAction {
  let categoryId: MovieCategory.ID
  let requestType: RequestType
  let list: [MoviePreview]
  let nextPage: String?
}
struct FailedPreviewsListAction: ANAction {
  let categoryId: MovieCategory.ID
  let requestType: RequestType
  let error: Error
}
