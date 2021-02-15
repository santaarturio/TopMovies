//
//  CategoryRequestsState.swift
//  TopMovies
//
//  Created by anikolaenko on 12.02.2021.
//

import ReSwift

struct CategoryRequestsState: StateType {
  let categoryRequests: [MovieCategory.ID: RequestState<[Movie.ID]>]
}

extension CategoryRequestsState {
  static func reduce(action: Action, state: CategoryRequestsState) -> CategoryRequestsState {
    switch action {
    case let MoviesDownloadingAction.requestFor(categoryID):
      var requests = state.categoryRequests
      requests[categoryID] = .requested
      return CategoryRequestsState(
        categoryRequests: requests
      )
    case let MoviesDownloadingAction.downloading(categoryID):
      var requests = state.categoryRequests
      requests[categoryID] = .downloading
      return CategoryRequestsState(
        categoryRequests: requests
      )
    case let MoviesDownloadingAction.completed(categoryID, movies):
      var requests = state.categoryRequests
      requests[categoryID] = .completed(data: movies.map{ $0.id })
      return CategoryRequestsState(
        categoryRequests: requests
      )
    case let MoviesDownloadingAction.failed(categoryID, error):
      var requests = state.categoryRequests
      requests[categoryID] = .failed(error: error)
      return CategoryRequestsState(
        categoryRequests: requests
      )
    default: return state
    }
  }
}
