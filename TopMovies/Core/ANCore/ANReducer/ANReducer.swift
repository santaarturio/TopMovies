//
//  ANReducer.swift
//  TopMovies
//
//  Created by Macbook Pro  on 19.04.2021.
//

func anReducer(action: ANAction, state: MainState) -> MainState {
  MainState(configurationState:
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
