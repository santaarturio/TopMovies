//
//  MoviesAction.swift
//  TopMovies
//
//  Created by Macbook Pro  on 21.02.2021.
//

import ReSwift

struct MoviesRequestAction: Action {
  let categoryId: MovieCategory.ID
  let requestType: RequestType
  
  enum RequestType { case reload, loadMore }
}

struct MoviesResponseAction: Action {
  let categoryId: MovieCategory.ID
  let list: [Movie]
  let requestedType: MoviesRequestAction.RequestType
  let responseType: ResponseType
  let nextPage: Int?
  
  enum ResponseType {
    case downloading, completed
    case failed(error: Error)
  }
}
