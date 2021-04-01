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
              moviesServiceState: .initial,
              movieCategoriesState:
                MovieCategoriesState(relational: [:],
                                     categoriesList: .initial),
              categoriesPaginationState:
                CategoriesPaginationState(paginated: [:]),
              moviesUpdateState:
                MoviesUpdateState(relational: [:]),
              moviesState:
                MoviesState(previewsRelational: PreviewsRelational(),
                            moviesRelational: MoviesRelational()))
  return MainState(configurationState:
                    ConfigurationState
                    .reduce(action: action,
                            state: state.configurationState),
                   appFlowState:
                    AppFlowState
                    .reduce(action: action,
                            state: state.appFlowState),
                   moviesServiceState:
                    MoviesServiceState
                    .reduce(action: action,
                            state: state.moviesServiceState),
                   movieCategoriesState:
                    MovieCategoriesState
                    .reduce(action: action,
                            state: state.movieCategoriesState),
                   categoriesPaginationState:
                    CategoriesPaginationState
                    .reduce(action: action,
                            state: state.categoriesPaginationState),
                   moviesUpdateState:
                    MoviesUpdateState
                    .reduce(action: action,
                            state: state.moviesUpdateState),
                   moviesState:
                    MoviesState
                    .reduce(action: action,
                            state: state.moviesState))
}
