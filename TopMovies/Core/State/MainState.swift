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
