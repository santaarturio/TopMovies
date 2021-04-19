//
//  MainState.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import ReSwift

struct MainState: StateType {
  let configurationState: ConfigurationState
  let appFlowState: AppFlowState
  let moviesServiceState: MoviesServiceState
  let movieCategoriesState: MovieCategoriesState
  let categoriesPaginationState: CategoriesPaginationState
  let moviesUpdateState: MoviesUpdateState
  let moviesState: MoviesState
}

extension MainState: ANState {
  static var defaultValue: MainState =
    .init(configurationState: ConfigurationState.defaultValue,
          appFlowState: AppFlowState.defaultValue,
          moviesServiceState: MoviesServiceState.defaultValue,
          movieCategoriesState: MovieCategoriesState.defaultValue,
          categoriesPaginationState: CategoriesPaginationState.defaultValue,
          moviesUpdateState: MoviesUpdateState.defaultValue,
          moviesState: MoviesState.defaultValue)
}
