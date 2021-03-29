//
//  MovieAPI.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import Moya

struct MovieAPI: MovieAPIProtocol {
  private let previewProvider = MoyaProvider<MovieTarget>()
  private let movieProvider = MoyaProvider<MovieUpdateTarget>()
  
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
      previewProvider.request(.init(requestedCategory: .init(category: requestedCategory))) { response in
        switch response {
        case let .success(data):
          do {
            var moviesListDTO = try JSONDecoder().decode(CategoryDTO.self, from: data.data)
            moviesListDTO.name = requestedCategory.rawValue
            categoriesDTO.append(moviesListDTO)
            requestsCounter += 1
          } catch {
            someError = error
          }
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
    previewProvider.request(.init(requestedCategory: .init(category: requestedCategory,
                                                           page: page))) { response in
      switch response {
      case let .success(data):
        do {
          var moviesListDTO = try JSONDecoder().decode(CategoryDTO.self, from: data.data)
          moviesListDTO.name = requestedCategory.rawValue
          category(.success(moviesListDTO))
        } catch {
          category(.failure(error))
        }
      case let .failure(error):
        category(.failure(error))
      }
    }
  }
  public func movie(id: MoviePreview.ID, _ result: @escaping (Result<MovieDTO, Error>) -> Void) {
    movieProvider.request(.init(movieId: id)) { response in
      switch response {
      case let .success(response):
        do {
          let movie = try JSONDecoder().decode(MovieDTO.self, from: response.data)
          result(.success(movie))
        } catch {
          result(.failure(error))
        }
      case let .failure(error):
        result(.failure(error))
      }
    }
  }
}
