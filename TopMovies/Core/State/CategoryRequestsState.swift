//
//  CategoryRequestsState.swift
//  TopMovies
//
//  Created by anikolaenko on 12.02.2021.
//

import ReSwift

struct CategoryRequestsState: StateType {
  let categoryRequests: [MovieCategory.ID: RequestState<[Movie.ID]>]
  let requestedPages: [MovieCategory.ID: CategoryPageState]
}

extension CategoryRequestsState {
  static func reduce(action: Action, state: CategoryRequestsState) -> CategoryRequestsState {
    switch action {
    case let MoviesDownloadingAction.requestFor(categoryID):
      var requests = state.categoryRequests
      requests[categoryID] = .requested
      return CategoryRequestsState(
        categoryRequests: requests,
        requestedPages: state.requestedPages
      )
    case let MoviesDownloadingAction.downloading(categoryID):
      var requests = state.categoryRequests
      requests[categoryID] = .downloading
      return CategoryRequestsState(
        categoryRequests: requests,
        requestedPages: state.requestedPages
      )
    case let MoviesDownloadingAction.completed(category, _):
      var categoryRequests = state.categoryRequests
      categoryRequests.updateValue(.completed(data: category.movies),
                                   forKey: category.id)
      var requestedPages = state.requestedPages
      requestedPages.updateValue(CategoryPageState(category: category),
                                 forKey: category.id)
      return CategoryRequestsState(
        categoryRequests: categoryRequests,
        requestedPages: requestedPages
      )
    case let MoviesDownloadingAction.failed(categoryID, error):
      var requests = state.categoryRequests
      requests[categoryID] = .failed(error: error)
      return CategoryRequestsState(
        categoryRequests: requests,
        requestedPages: state.requestedPages
      )
    default: return state
    }
  }
}
