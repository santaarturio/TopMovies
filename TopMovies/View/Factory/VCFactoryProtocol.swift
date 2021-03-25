//
//  VCFactoryProtocol.swift
//  TopMovies
//
//  Created by Macbook Pro  on 20.03.2021.
//

protocol VCFactoryProtocol {
  func createAllCategoriesVC() -> TopMoviesVC
  func createCategoryVC() -> MoviesCategoryVC
  func createMovieVC() -> MovieVC
}
