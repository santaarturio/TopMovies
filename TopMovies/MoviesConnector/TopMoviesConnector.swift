//
//  TopMoviesConnector.swift
//  TopMovies
//
//  Created by anikolaenko on 10.02.2021.
//

import ReSwift

class TopMoviesConnector: BaseConnector<TopMoviesProps> {
    
    required init(updateProps: @escaping (TopMoviesProps) -> Void) {
        super.init(updateProps: updateProps)
    }
    
    override func newState(state: MainState) {
        switch state.moviesListState.moviesList {
            case let .completed(moviesID):
                let props =
                    TopMoviesProps(movieCategories: [
                        MovieCategoryProps(categoryNameText: state.moviesListState.moviesListName,
                                           movies: moviesID.map{ MovieCollectionProps(movie: state.moviesListState.relational[$0]!) })
                    ])
                _updateProps(props)
            default: break
        }
    }
}
