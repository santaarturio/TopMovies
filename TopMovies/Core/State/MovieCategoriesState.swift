//
//  MovieCategoriesState.swift
//  TopMovies
//
//  Created by anikolaenko on 11.02.2021.
//

import ReSwift

struct MovieCategoriesState: StateType {
  let relational: [MovieCategory.ID: MovieCategory]
  let categoriesList: RequestState<[MovieCategory.ID]>
  let categoryRequests: [MovieCategory.ID: RequestState<[Movie.ID]>]
}

extension MovieCategoriesState {
  static func reduce(action: Action, state: MovieCategoriesState) -> MovieCategoriesState {
    
    // MARK: - MovieCategoriesAction
    switch action {
    case MovieCategoriesAction.request:
      return MovieCategoriesState(
        relational: state.relational,
        categoriesList: .requested,
        categoryRequests: state.categoryRequests
      )
    case MovieCategoriesAction.downloading:
      return MovieCategoriesState(
        relational: state.relational,
        categoriesList: .downloading,
        categoryRequests: state.categoryRequests
      )
    case let MovieCategoriesAction.completed(categories):
      let categoriesIDArray = categories.map{ $0.id }
      return MovieCategoriesState(
        relational: Dictionary(uniqueKeysWithValues: zip(categoriesIDArray, categories)),
        categoriesList: .completed(data: categoriesIDArray),
        categoryRequests: state.categoryRequests
      )
    case let MovieCategoriesAction.failed(error):
      return MovieCategoriesState(
        relational: state.relational,
        categoriesList: .failed(error: error),
        categoryRequests: state.categoryRequests
      )
    // MARK: - MoviesDownloadingAction
    case let MoviesDownloadingAction.requestFor(categoryID):
      var requests = state.categoryRequests
      requests[categoryID] = .requested
      return MovieCategoriesState(
        relational: state.relational,
        categoriesList: state.categoriesList,
        categoryRequests: requests
      )
    case let MoviesDownloadingAction.downloading(categoryID):
      var requests = state.categoryRequests
      requests[categoryID] = .downloading
      return MovieCategoriesState(
        relational: state.relational,
        categoriesList: state.categoriesList,
        categoryRequests: requests
      )
    case let MoviesDownloadingAction.completed(categoryID, movies):
      var requests = state.categoryRequests
      requests[categoryID] = .completed(data: movies.map{ $0.id })
      return MovieCategoriesState(
        relational: state.relational,
        categoriesList: state.categoriesList,
        categoryRequests: requests
      )
    case let MoviesDownloadingAction.failed(categoryID, error):
      var requests = state.categoryRequests
      requests[categoryID] = .failed(error: error)
      return MovieCategoriesState(
        relational: state.relational,
        categoriesList: state.categoriesList,
        categoryRequests: requests
      )
    default: return state
    }
  }
}
