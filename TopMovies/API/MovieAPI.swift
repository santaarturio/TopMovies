//
//  MovieAPI.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import Moya

final class MovieAPI: MovieAPIProtocol {
  private let provider = MoyaProvider<MoviesDBTarget>()
  
  // MARK: - All Categories
  public func allMovieCategories(categoriesResult: @escaping (Result<[CategoryDTOWrapper], Error>) -> Void) {
    allMovieCategories(callBackQueue: DispatchQueue.defaultSerialQueue,
                       categoriesResult: categoriesResult)
  }
  public func allMovieCategories(callBackQueue queue: DispatchQueue,
                                 categoriesResult: @escaping (Result<[CategoryDTOWrapper], Error>) -> Void) {
    var categoriesDTO: [CategoryDTOWrapper] = []
    var someError: Error?
    
    let completionQueue = DispatchQueue(label: "com.topMovies.apiCompletion",
                                        qos: .userInitiated)
    let categoriesGroup = DispatchGroup()
    MovieCategoryRequest.allCases.forEach { categoryRequest in
      DispatchQueue
        .global(qos: .utility)
        .async(group: categoriesGroup) { [unowned self] in
          categoriesGroup.enter()
          provider.request(.init(category: categoryRequest)) { response in
            switch response {
            case let .success(data):
              do {
                let moviesListDTO = try JSONDecoder().decode(CategoryDTO.self, from: data.data)
                completionQueue.sync { categoriesDTO.append(.init(id: categoryRequest.rawValue,
                                                                  name: CategoryDTO.name(by: categoryRequest),
                                                                  dto: moviesListDTO)) }
              } catch {
                completionQueue.sync { someError = error }
              }
            case let .failure(error):
              completionQueue.sync { someError = error }
            }
            categoriesGroup.leave()
          }
        }
    }
    categoriesGroup.notify(queue: queue) {
      if let error = someError {
        categoriesResult(.failure(error))
      } else {
        categoriesResult(.success(categoriesDTO))
      }
    }
  }
  
  // MARK: - Category
  public func category(request: MovieCategoryRequest,
                       page: Int,
                       categoryResult: @escaping (Result<CategoryDTOWrapper, Error>) -> Void) {
    provider.request(.init(category: request, page: page)) { response in
      switch response {
      case let .success(data):
        do {
          let moviesListDTO = try JSONDecoder().decode(CategoryDTO.self, from: data.data)
          categoryResult(.success(.init(id: request.rawValue,
                                        name: CategoryDTO.name(by: request),
                                        dto: moviesListDTO)))
        } catch {
          categoryResult(.failure(error))
        }
      case let .failure(error):
        categoryResult(.failure(error))
      }
    }
  }
  
  // MARK: - Movie
  public func movie(id: MoviePreview.ID,
                    movieResult: @escaping (Result<MovieDTO, Error>) -> Void) {
    provider.request(.movie(id: id)) { response in
      switch response {
      case let .success(response):
        do {
          let movie = try JSONDecoder().decode(MovieDTO.self, from: response.data)
          movieResult(.success(movie))
        } catch {
          movieResult(.failure(error))
        }
      case let .failure(error):
        movieResult(.failure(error))
      }
    }
  }
}
