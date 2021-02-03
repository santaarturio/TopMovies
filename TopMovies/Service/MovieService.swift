//
//  MovieService.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import Foundation
import ReSwift

class MovieService: StoreSubscriber {
    typealias StoreSubscriberStateType = MoviesListState

    private let movieAPI: MovieAPIProtocol
    
    public init(movieAPI: MovieAPIProtocol) {
        self.movieAPI = movieAPI
    }
    
    func newState(state: MoviesListState) {
        switch state.moviesList {
        case .requested:
            mainStore.dispatch(MoviesListAction.downloading)
            movieAPI.topMovies { (result) in
                switch result {
                case let .success(movies):
                    mainStore.dispatch(MoviesListAction.completed(movies: movies))
                case let .failure(error):
                    mainStore.dispatch(MoviesListAction.failed(error: error))
                }
            }
        default: break
        }
    }
}
