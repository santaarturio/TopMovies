//
//  MovieAPI.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import Foundation
import Moya

protocol MovieAPIProtocol {
    func topMovies(_ movies: @escaping (Result<[Movie], Error>) -> Void)
}

struct MovieAPI: MovieAPIProtocol {
    private let provider = MoyaProvider<MovieTarget>()
    
    public func topMovies(_ movies: @escaping (Result<[Movie], Error>) -> Void) {
        movies(.failure(URLError(.badURL)))
        provider.request(.marvelMovies) { (result) in
            switch result {
            case let .success(data):
                print(data)
            case let .failure(error):
                movies(.failure(error))
            }
        }
    }
}
