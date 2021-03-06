//
//  MockMovieAPI.swift
//  TopMoviesTests
//
//  Created by anikolaenko on 11.03.2021.
//

@testable import TopMovies

class MockSuccessfulMovieAPI: MovieAPIProtocol {
  func allMovieCategories(_ categories: @escaping (Result<[CategoryDTO], Error>) -> Void) {
    categories(.success([mockCategoryDTO, mockCategoryDTO2]))
  }
  
  func category(_ requestedCategory: MovieCategoryRequest, page: Int, _ category: @escaping (Result<CategoryDTO, Error>) -> Void) {
    category(.success(mockCategoryDTO))
  }
  
  func movie(id: MoviePreview.ID, _ result: @escaping (Result<MovieDTO, Error>) -> Void) {
    result(.success(mockUpdatedMovieDTO))
  }
}

class MockUnsuccessfulMovieAPI: MovieAPIProtocol {
  func allMovieCategories(_ categories: @escaping (Result<[CategoryDTO], Error>) -> Void) {
    categories(.failure(MockError(description: "failed all movie categories")))
  }
  
  func category(_ requestedCategory: MovieCategoryRequest, page: Int, _ category: @escaping (Result<CategoryDTO, Error>) -> Void) {
    category(.failure(MockError(description: "failed movie category")))
  }
  
  func movie(id: MoviePreview.ID, _ result: @escaping (Result<MovieDTO, Error>) -> Void) {
    result(.failure(MockError(description: "failed movie update")))
  }
}
