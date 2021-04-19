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
}

extension MovieCategoriesState: ANState {
  static var defaultValue: MovieCategoriesState = .init(relational: [:],
                                                        categoriesList: .initial)
}

extension MovieCategoriesState {
  static func reduce(action: ANAction, state: MovieCategoriesState) -> MovieCategoriesState {
    switch action {
    case is RequestMovieCategoriesAction:
      return MovieCategoriesState(
        relational: state.relational,
        categoriesList: .requested
      )
    case is DownloadingMovieCategoriesAction:
      return MovieCategoriesState(
        relational: state.relational,
        categoriesList: .downloading
      )
    case let action as CompletedMovieCategoriesAction:
      let categoriesIDArray = action.categories.map(\.category.id)
      return MovieCategoriesState(
        relational: Dictionary(uniqueKeysWithValues:
                                zip(categoriesIDArray, action.categories.map(\.category))),
        categoriesList: .completed(data: categoriesIDArray)
      )
    case let action as FailedMovieCategoriesAction:
      return MovieCategoriesState(
        relational: state.relational,
        categoriesList: .failed(error: action.error)
      )
    default: return state
    }
  }
}
