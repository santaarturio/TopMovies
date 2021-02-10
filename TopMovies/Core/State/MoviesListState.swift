//
//  MoviesListState.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import ReSwift

typealias MoviesRelational = [Movie.ID: Movie]

struct MoviesListState: StateType {
    let moviesListName: String
    let moviesList: RequestState<[Movie.ID]>
    let relational: MoviesRelational
}

extension MoviesListState {
    static func reduce(action: Action, state: MoviesListState) -> MoviesListState {
        switch action {
        case MoviesListAction.request:
            return MoviesListState(moviesListName: state.moviesListName,
                                   moviesList: .requested,
                                   relational: state.relational)
        case MoviesListAction.downloading:
            return MoviesListState(moviesListName: state.moviesListName,
                                   moviesList: .downloading,
                                   relational: state.relational)
        case let MoviesListAction.completed(categoryName, movies):
            let moviesIDArray = movies.map({ $0.id })
            return MoviesListState(moviesListName: categoryName,
                                   moviesList: .completed(data: moviesIDArray),
                                   relational: Dictionary(uniqueKeysWithValues: zip(moviesIDArray, movies)))
        case let MoviesListAction.failed(error):
            return MoviesListState(moviesListName: state.moviesListName,
                                   moviesList: .failed(error: error),
                                   relational: state.relational)
        default: return state
        }
    }
}
