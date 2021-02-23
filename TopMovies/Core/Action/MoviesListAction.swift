//
//  MoviesListAction.swift
//  TopMovies
//
//  Created by Macbook Pro  on 21.02.2021.
//

import ReSwift

enum RequestType { case reload, loadMore }

struct RequestedMoviesListAction: Action {
  let categoryId: MovieCategory.ID
  let requestType: RequestType
}
struct DownloadingMoviesListAction: Action {
  let categoryId: MovieCategory.ID
  let requestType: RequestType
}
struct CompletedMoviesListAction: Action {
  let categoryId: MovieCategory.ID
  let requestType: RequestType
  let list: [Movie]
  let nextPage: Int?
}
struct FailedMoviesListAction: Action {
  let categoryId: MovieCategory.ID
  let requestType: RequestType
  let error: Error
}
