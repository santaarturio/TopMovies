//
//  VCFactoryProtocol.swift
//  TopMovies
//
//  Created by Macbook Pro  on 20.03.2021.
//

protocol VCFactoryProtocol {
  func createAllCategoriesVC() -> TopMoviesVC
  func createCategoryVC(_ categoryId: MovieCategory.ID) -> MoviesCategoryVC
}
