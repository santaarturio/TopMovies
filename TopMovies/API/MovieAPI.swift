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
  func topMovies(_ movies: @escaping MoviesCompletion, category: MovieTarget.Target?)
}

struct MovieAPI: MovieAPIProtocol {
  private let provider = MoyaProvider<MovieTarget>()
  
<<<<<<< ours
  public func topMovies(_ moviesList: @escaping MoviesCompletion) {
    provider.request(.init(target: .marvelMovies)) { (response) in
      switch response {
      case let .success(data):
        if let moviesListDTO = DataDecoder.decode(MoviesListDTO.self, fromJSON: data.data) {
          moviesList(.success([moviesListDTO]))
        } else { print("Decoder didn't decode") }
      case let .failure(error):
        moviesList(.failure(error))
=======
  public func topMovies(_ moviesList: @escaping MoviesCompletion, category: MovieTarget.Target?) {
    let numberOfRequests = category != nil ? 1 : 4
    var categoriesDTO: [MoviesListDTO] = []
    var someError: Error?
    var requestsCounter = 0 {
      didSet {
        if requestsCounter == numberOfRequests
            && !categoriesDTO.isEmpty {
          moviesList(.success(categoriesDTO))
        } else if someError != nil
                    && requestsCounter == numberOfRequests
                    && categoriesDTO.isEmpty {
          moviesList(.failure(someError!))
        }
>>>>>>> theirs
      }
    }
    if let category = category {
      provider.request(.init(target: category)) { (response) in
        switch response {
        case let .success(data):
          if var moviesListDTO = DataDecoder.decode(MoviesListDTO.self, fromJSON: data.data) {
            moviesListDTO.name = createCategoryName(for: category)
            categoriesDTO.append(moviesListDTO)
            requestsCounter += 1
          } else { print("Decoder didn't decode") }
        case let .failure(error):
          someError = error
          requestsCounter += 1
        }
      }
    } else {
      let targets: [MovieTarget.Target] = [.nowPlaying(page: 1),
                                           .popular(page: 1),
                                           .topRated(page: 1),
                                           .upcoming(page: 1)]
      targets.forEach{ target in
        provider.request(.init(target: target)) { (response) in
          switch response {
          case let .success(data):
            if var moviesListDTO = DataDecoder.decode(MoviesListDTO.self, fromJSON: data.data) {
              moviesListDTO.name = createCategoryName(for: target)
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
  }
  
  private func createCategoryName(for target: MovieTarget.Target) -> String {
    switch target {
    case .nowPlaying(page: _):
      return "Now Playing"
    case .popular(page: _):
      return "Popular"
    case.topRated(page: _):
      return "Top Rated"
    case .upcoming(page: _):
      return "Upcoming"
    }
  }
}
