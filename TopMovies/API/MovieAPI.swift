//
//  MovieAPI.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import Foundation
import Moya

typealias MoviesCompletion = (Result<[MoviesListDTO], Error>) -> Void

protocol MovieAPIProtocol {
  func topMovies(_ movies: @escaping MoviesCompletion)
}

struct MovieAPI: MovieAPIProtocol {
  private let provider = MoyaProvider<MovieTarget>()
  
  public func topMovies(_ moviesList: @escaping MoviesCompletion) {
    provider.request(.init(target: .marvelMovies)) { (response) in
      switch response {
      case let .success(data):
        if let moviesListDTO = DataDecoder.decode(MoviesListDTO.self, fromJSON: data.data) {
          moviesList(.success([moviesListDTO]))
        } else { print("Decoder didn't decode") }
      case let .failure(error):
        moviesList(.failure(error))
      }
    }
  }
}
