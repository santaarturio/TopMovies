//
//  MovieService.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import Foundation

struct MovieService {
    private let movieAPI: MovieAPIProtocol
    
    public init(movieAPI: MovieAPIProtocol) {
        self.movieAPI = movieAPI
    }
    
    public func getMovies(result: @escaping (Result<MoviesList, Error>) -> ()) {
        movieAPI.topMovies { (resultAPI) in
            result(resultAPI)
        }
    }
}
