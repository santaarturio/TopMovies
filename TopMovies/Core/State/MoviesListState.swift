//
//  MoviesListState.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import ReSwift

struct MoviesListState: StateType {
     let moviesList: RequestState<[Movie.ID]>
     let relational: MoviesRelational // which is [Movie.ID: Movie]
}

extension MoviesListState {
    static func reduce(action: Action, state: MoviesListState) -> MoviesListState {
        switch action {
        case MoviesListAction.request:
            return MoviesListState(moviesList: .requested,
                                   relational: state.relational)
        case MoviesListAction.downloading:
            return MoviesListState(moviesList: .downloading,
                                   relational: state.relational)
        case let MoviesListAction.completed(data):
            return MoviesListState(moviesList: .completed(data: Array(data.keys)),
                                   relational: data)
        case let MoviesListAction.failed(error):
            return MoviesListState(moviesList: .failed(error: error),
                                   relational: state.relational)
        default: return state
        }
    }
}
