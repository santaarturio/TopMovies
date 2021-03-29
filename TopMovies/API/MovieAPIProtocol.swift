//
//  MovieAPIProtocol.swift
//  TopMovies
//
//  Created by anikolaenko on 29.03.2021.
//

protocol MovieAPIProtocol {
  func allMovieCategories(_ categories: @escaping (Result<[CategoryDTO], Error>) -> Void)
  func category(_ requestedCategory: MovieCategoryRequest,
                page: Int,
                _ category: @escaping (Result<CategoryDTO, Error>) -> Void)
  func movie(id: MoviePreview.ID, _ result: @escaping (Result<MovieDTO, Error>) -> Void)
}
