//
//  MovieService.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import Foundation
import ReSwift

class MovieService: StoreSubscriber {
    typealias StoreSubscriberStateType = MainState

    private let movieAPI: MovieAPIProtocol
    
    init(movieAPI: MovieAPIProtocol) {
        self.movieAPI = movieAPI
        mainStore.subscribe(self)
    }
    
    func newState(state: MainState) {
        switch state.moviesListState.moviesList {
        case .requested:
            mainStore.dispatch(MoviesListAction.downloading)
            movieAPI.topMovies { (result) in
                switch result {
                case let .success(moviesList):
                    mainStore.dispatch(MoviesListAction
                                        .completed(movies: moviesList.results.map(MoviesDTOMapper.map(_:))))
                case let .failure(error):
                    mainStore.dispatch(MoviesListAction.failed(error: error))
                }
            }
        default: break
        }
    }
}
