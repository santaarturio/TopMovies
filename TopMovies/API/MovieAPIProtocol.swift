//
//  MovieAPIProtocol.swift
//  TopMovies
//
//  Created by anikolaenko on 29.03.2021.
//

import Foundation

protocol MovieAPIProtocol {
  func allMovieCategories(categoriesResult: @escaping (Result<[CategoryDTOWrapper], Error>) -> Void)
  func allMovieCategories(callBackQueue queue: DispatchQueue,
                          categoriesResult: @escaping (Result<[CategoryDTOWrapper], Error>) -> Void)
  func category(request: MovieCategoryRequest,
                page: Int,
                categoryResult: @escaping (Result<CategoryDTOWrapper, Error>) -> Void)
  func movie(id: MoviePreview.ID,
             movieResult: @escaping (Result<MovieDTO, Error>) -> Void)
}
