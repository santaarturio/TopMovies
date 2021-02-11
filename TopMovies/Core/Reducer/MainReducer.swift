//
//  MainReducer.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import ReSwift

func mainReducer(action: Action, state: MainState?) -> MainState {
  let state = state ??
    MainState(configurationState: .initial,
              appFlowState: .launching,
              movieCategoriesState:
                MovieCategoriesState(relational: [:],
                                     categoriesList: .initial,
                                     categoryRequests: [:]),
              moviesState:
                MoviesState(relational: MoviesRelational()))
  return MainState(configurationState:
                    ConfigurationState
                    .reduce(action: action,
                            state: state.configurationState),
                   appFlowState:
                    AppFlowState
                    .reduce(action: action,
                            state: state.appFlowState),
                   movieCategoriesState:
                    MovieCategoriesState
                    .reduce(action: action,
                            state: state.movieCategoriesState),
                   moviesState:
                    MoviesState
                    .reduce(action: action,
                            state: state.moviesState))
}
