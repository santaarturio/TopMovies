//
//  MoviesListState.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import ReSwift

struct MoviesListState: StateType {
    let moviesList: RequestState<MoviesList>
}

extension MoviesListState {
    static func reduce(action: Action, state: MoviesListState) -> MoviesListState {
        switch action {
        case MoviesListAction.request:
            return MoviesListState(moviesList: .requested)
        case MoviesListAction.downloading:
            return MoviesListState(moviesList: .downloading)
        case let MoviesListAction.completed(data):
            return MoviesListState(moviesList: .completed(data: data))
        case let MoviesListAction.failed(error):
            return MoviesListState(moviesList: .failed(error: error))
        default: return state
        }
    }
}
