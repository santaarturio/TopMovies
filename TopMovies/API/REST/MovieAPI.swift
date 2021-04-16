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
    var someError: Error?
    var categoryWrappers: [MovieCategoryRequest: Result<CategoryDTOWrapper, Error>] = [:]
    
    let completionQueue = DispatchQueue(label: "com.topMovies.apiCompletion",
                                        qos: .userInitiated)
    let categoriesGroup = DispatchGroup()
    MovieCategoryRequest.allCases.forEach { request in
      DispatchQueue
        .global(qos: .utility)
        .async(group: categoriesGroup) { [unowned self] in
          categoriesGroup.enter()
          provider.request(.init(category: request)) { result in
            completionQueue.sync {
              categoryWrappers[request] = handleResult(result)
                .map { CategoryDTOWrapper.init(dto: $0, request: request) }
            }
            categoriesGroup.leave()
          }
        }
    }
    categoriesGroup.notify(queue: queue) {
      let wrappersDict = categoryWrappers.compactMapValues { result -> CategoryDTOWrapper? in
        do { return try result.get() } catch { someError = error; return nil }
      }
      if let error = someError {
        categoriesResult(.failure(error))
      } else {
        categoriesResult(.success(MovieCategoryRequest.allCases.map { wrappersDict[$0]! }))
      }
    }
  }
  
  // MARK: - Category
  public func category(request: MovieCategoryRequest,
                       page: String?,
                       categoryResult: @escaping (Result<CategoryDTOWrapper, Error>) -> Void) {
    provider.request(.init(category: request, page: page ?? "1")) { result in
      categoryResult(handleResult(result).map { CategoryDTOWrapper.init(dto: $0, request: request) })
    }
  }
  
  // MARK: - Movie
  public func movie(id: MoviePreview.ID,
                    movieResult: @escaping (Result<MovieDTOWrapper, Error>) -> Void) {
    provider.request(.movie(id: id)) { result in
      movieResult(handleResult(result).map(MovieDTOWrapper.init(dto:)))
    }
  }
}

private func handleResult<T: Decodable>(_ result: Result<Response, MoyaError>) -> Result<T, Error> {
  do {
    return .success(try JSONDecoder().decode(T.self, from: result.get().data))
  } catch {
    return .failure(error)
  }
}

private extension CategoryDTOWrapper {
  init(dto: CategoryDTO, request: MovieCategoryRequest) {
    self.init(id: request.rawValue,
              title: CategoryDTO.name(by: request),
              dto: dto)
  }
}
