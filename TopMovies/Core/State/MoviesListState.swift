//
//  MoviesListState.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import ReSwift

typealias MoviesRelational = [Movie.ID: Movie]

struct MoviesListState: StateType {
     let moviesList: RequestState<[Movie.ID]>
     let relational: MoviesRelational 
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
        case let MoviesListAction.completed(movies):
            let moviesIDArray = movies.map({ $0.id })
            return MoviesListState(moviesList: .completed(data: moviesIDArray),
                                   relational: Dictionary(uniqueKeysWithValues: zip(moviesIDArray, movies)))
        case let MoviesListAction.failed(error):
            return MoviesListState(moviesList: .failed(error: error),
                                   relational: state.relational)
        default: return state
        }
    }
}
