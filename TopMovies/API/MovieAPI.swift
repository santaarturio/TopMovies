//
//  MovieAPI.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import Foundation
import Moya

protocol MovieAPIProtocol {
  func allMovieCategories(_ categories: @escaping (Result<[MoviesListDTO], Error>) -> Void)
  func category(with target: MovieTarget.Target, _ category: @escaping (Result<MoviesListDTO, Error>) -> Void)
}

struct MovieAPI: MovieAPIProtocol {
  private let provider = MoyaProvider<MovieTarget>()
  
  public func allMovieCategories(_ categories: @escaping (Result<[MoviesListDTO], Error>) -> Void) {
    let numberOfRequests = 4
    var categoriesDTO: [MoviesListDTO] = []
    var someError: Error?
    var requestsCounter = 0 {
      didSet {
        if requestsCounter == numberOfRequests && !categoriesDTO.isEmpty {
          categories(.success(categoriesDTO))
        } else if someError != nil
                    && requestsCounter == numberOfRequests
                    && categoriesDTO.isEmpty {
          someError.map { categories(.failure($0)) }
        }
      }
    }
    let targets: [MovieTarget.Target] = [.nowPlaying(),
                                         .popular(),
                                         .topRated(),
                                         .upcoming()]
    targets.forEach{ target in
      provider.request(.init(target: target)) { (response) in
        switch response {
        case let .success(data):
          if var moviesListDTO = DataDecoder.decode(MoviesListDTO.self, fromJSON: data.data) {
            moviesListDTO.name = CategoryNameCoder.encodeName(for: target)
            categoriesDTO.append(moviesListDTO)
            requestsCounter += 1
          } else { print("Decoder didn't decode") }
        case let .failure(error):
          someError = error
          requestsCounter += 1
        }
      }
    }
  }
  public func category(with target: MovieTarget.Target, _ category: @escaping (Result<MoviesListDTO, Error>) -> Void) {
    provider.request(.init(target: target)) { (response) in
      switch response {
      case let .success(data):
        if var moviesListDTO = DataDecoder.decode(MoviesListDTO.self, fromJSON: data.data) {
          moviesListDTO.name = CategoryNameCoder.encodeName(for: target)
          category(.success(moviesListDTO))
        } else { print("Decoder didn't decode") }
      case let .failure(error):
        category(.failure(error))
      }
    }
  }
}
