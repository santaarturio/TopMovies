//
//  MovieAPI.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import Foundation

protocol MovieAPIProtocol {
    func topMovies(_ movies: @escaping (Result<MoviesList, Error>) -> ())
}

struct MovieAPI: MovieAPIProtocol {
    func topMovies(_ movies: @escaping (Result<MoviesList, Error>) -> ()) {
        movies(.failure(URLError(.badURL)))
    }
}
