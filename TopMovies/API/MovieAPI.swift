//
//  MovieAPI.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import Foundation
import Moya

protocol MovieAPIProtocol {
  func allMovieCategories(_ categories: @escaping (Result<[CategoryDTO], Error>) -> Void)
  func category(_ requestedCategory: MovieCategoryRequest,
                page: Int,
                _ category: @escaping (Result<CategoryDTO, Error>) -> Void)
}

struct MovieAPI: MovieAPIProtocol {
  private let provider = MoyaProvider<MovieTarget>()
  
  public func allMovieCategories(_ categories: @escaping (Result<[CategoryDTO], Error>) -> Void) {
    var categoriesDTO: [CategoryDTO] = []
    var someError: Error?
    let requests = MovieCategoryRequest.allCases
    var requestsCounter = 0 {
      didSet {
        let numberOfRequests = requests.count
        if requestsCounter == numberOfRequests && !categoriesDTO.isEmpty {
          categories(.success(categoriesDTO))
        } else if someError != nil
                    && requestsCounter == numberOfRequests {
          someError.map { categories(.failure($0)) }
        }
      }
    }
    requests.forEach { requestedCategory in
      provider.request(.init(requestedCategory: .init(category: requestedCategory))) { (response) in
        switch response {
        case let .success(data):
          if var moviesListDTO = DataDecoder.decode(CategoryDTO.self, fromJSON: data.data) {
            moviesListDTO.name = requestedCategory.rawValue
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
  public func category(_ requestedCategory: MovieCategoryRequest,
                       page: Int,
                       _ category: @escaping (Result<CategoryDTO, Error>) -> Void) {
    provider.request(.init(requestedCategory: .init(category: requestedCategory,
                                                    page: page))) { (response) in
      switch response {
      case let .success(data):
        if var moviesListDTO = DataDecoder.decode(CategoryDTO.self, fromJSON: data.data) {
          moviesListDTO.name = requestedCategory.rawValue
          category(.success(moviesListDTO))
        } else { print("Decoder didn't decode") }
      case let .failure(error):
        category(.failure(error))
      }
    }
  }
}
