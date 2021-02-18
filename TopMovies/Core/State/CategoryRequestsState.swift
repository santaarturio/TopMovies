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
  let alreadyDownloaded: [MovieCategory.ID: [Movie.ID]]
}

extension CategoryRequestsState {
  static func reduce(action: Action, state: CategoryRequestsState) -> CategoryRequestsState {
    switch action {
    case let MoviesDownloadingAction.requestFor(categoryID):
      var requests = state.categoryRequests
      requests[categoryID] = .requested
      return CategoryRequestsState(
        categoryRequests: requests,
        requestedPages: state.requestedPages,
        alreadyDownloaded: state.alreadyDownloaded
      )
    case let MoviesDownloadingAction.downloading(categoryID):
      var requests = state.categoryRequests
      requests[categoryID] = .downloading
      return CategoryRequestsState(
        categoryRequests: requests,
        requestedPages: state.requestedPages,
        alreadyDownloaded: state.alreadyDownloaded
      )
    case let MoviesDownloadingAction.completed(category, movies):
      var categoryRequests = state.categoryRequests
      categoryRequests.updateValue(.completed(data: category.movies),
                                   forKey: category.id)
      var requestedPages = state.requestedPages
      requestedPages.updateValue(CategoryPageState(category: category),
                                 forKey: category.id)
      var alreadyDownloaded = state.alreadyDownloaded
      alreadyDownloaded[category.id] == nil ?
        alreadyDownloaded[category.id] = movies.map(\.id) :
        alreadyDownloaded[category.id]?.append(contentsOf: movies.map(\.id))
      return CategoryRequestsState(
        categoryRequests: categoryRequests,
        requestedPages: requestedPages,
        alreadyDownloaded: alreadyDownloaded
      )
    case let MoviesDownloadingAction.failed(categoryID, error):
      var requests = state.categoryRequests
      requests[categoryID] = .failed(error: error)
      return CategoryRequestsState(
        categoryRequests: requests,
        requestedPages: state.requestedPages,
        alreadyDownloaded: state.alreadyDownloaded
      )
    default: return state
    }
  }
}
