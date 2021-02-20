//
//  MovieCategoriesState.swift
//  TopMovies
//
//  Created by anikolaenko on 11.02.2021.
//

import ReSwift

struct MovieCategoriesState: StateType {
  let categoriesList: RequestState<[MovieCategory.ID]>
  let relational: [MovieCategory.ID: MovieCategory]
}

extension MovieCategoriesState {
  static func reduce(action: Action, state: MovieCategoriesState) -> MovieCategoriesState {
    switch action {
    case MovieCategoriesAction.request:
      return MovieCategoriesState(
        categoriesList: .requested,
        relational: state.relational
      )
    case MovieCategoriesAction.downloading:
      return MovieCategoriesState(
        categoriesList: .downloading,
        relational: state.relational
      )
    case let MovieCategoriesAction.completed(categories, _,_):
      let categoriesIDArray = categories.map(\.id)
      return MovieCategoriesState(
        categoriesList: .completed(data: categoriesIDArray),
        relational: Dictionary(uniqueKeysWithValues:
                                zip(categoriesIDArray, categories))
      )
    case let MovieCategoriesAction.failed(error):
      return MovieCategoriesState(
        categoriesList: .failed(error: error),
        relational: state.relational
      )
    default: return state
    }
  }
}
