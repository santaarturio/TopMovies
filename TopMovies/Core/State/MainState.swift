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
  let movieCategoriesState: MovieCategoriesState
  let categoriesPaginationState: CategoriesPaginationState
  let moviesState: MoviesState
}
