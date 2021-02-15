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

extension MovieCategoriesState {
  static func reduce(action: Action, state: MovieCategoriesState) -> MovieCategoriesState {
    switch action {
    case MovieCategoriesAction.request:
      return MovieCategoriesState(
        relational: state.relational,
        categoriesList: .requested
      )
    case MovieCategoriesAction.downloading:
      return MovieCategoriesState(
        relational: state.relational,
        categoriesList: .downloading
      )
    case let MovieCategoriesAction.completed(categories):
      let categoriesIDArray = categories.map(\.id)
      return MovieCategoriesState(
        relational: Dictionary(uniqueKeysWithValues:
                                zip(categoriesIDArray, categories)),
        categoriesList: .completed(data: categoriesIDArray)
      )
    case let MovieCategoriesAction.failed(error):
      return MovieCategoriesState(
        relational: state.relational,
        categoriesList: .failed(error: error)
      )
    default: return state
    }
  }
}
