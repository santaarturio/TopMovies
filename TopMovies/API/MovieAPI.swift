//
//  MovieAPI.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import Foundation

protocol MovieAPIProtocol {
    func topMovies(_ movies: @escaping (Result<[Movie], Error>) -> ())
}

struct MovieAPI: MovieAPIProtocol {
    func topMovies(_ movies: @escaping (Result<[Movie], Error>) -> ()) {
        movies(.failure(URLError(.badURL)))
    }
}
