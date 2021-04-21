//
//  MainReducer.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import ReSwift

func mainReducer(action: Action, state: MainState?) -> MainState {
  let state = state ?? MainState.defaultValue
  
  return MainState(configurationState:
                    ConfigurationState
                    .reduce(action: action as! ANAction,
                            state: state.configurationState),
                   appFlowState:
                    AppFlowState
                    .reduce(action: action as! ANAction,
                            state: state.appFlowState),
                   moviesServiceState:
                    MoviesServiceState
                    .reduce(action: action as! ANAction,
                            state: state.moviesServiceState),
                   movieCategoriesState:
                    MovieCategoriesState
                    .reduce(action: action as! ANAction,
                            state: state.movieCategoriesState),
                   categoriesPaginationState:
                    CategoriesPaginationState
                    .reduce(action: action as! ANAction,
                            state: state.categoriesPaginationState),
                   moviesUpdateState:
                    MoviesUpdateState
                    .reduce(action: action as! ANAction,
                            state: state.moviesUpdateState),
                   moviesState:
                    MoviesState
                    .reduce(action: action as! ANAction,
                            state: state.moviesState))
}
