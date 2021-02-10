//
//  MainReducer.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import ReSwift

func mainReducer(action: Action, state: MainState?) -> MainState {
    let state = state ?? MainState(configurationState: .initial,
                                   appFlowState: .launching,
                                   moviesListState: MoviesListState(moviesListName: String(),
                                                                    moviesList: .initial,
                                                                    relational: [:]))
    return MainState(configurationState: ConfigurationState.reduce(action: action, state: state.configurationState),
                     appFlowState: AppFlowState.reduce(action: action, state: state.appFlowState),
                     moviesListState: MoviesListState.reduce(action: action, state: state.moviesListState))
}
