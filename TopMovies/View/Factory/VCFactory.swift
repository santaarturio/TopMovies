//
//  VCFactory.swift
//  TopMovies
//
//  Created by anikolaenko on 18.03.2021.
//

final class VCFactory: VCFactoryProtocol {
  func createAllCategoriesVC() -> TopMoviesVC {
    TopMoviesVC()
  }
  func createCategoryVC(_ categoryId: MovieCategory.ID) -> MoviesCategoryVC {
    MoviesCategoryVC()
  }
}
