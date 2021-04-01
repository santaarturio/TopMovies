//
//  VCFactory.swift
//  TopMovies
//
//  Created by anikolaenko on 18.03.2021.
//

final class VCFactory: VCFactoryProtocol {
  func createWelcomeVC() -> WelcomeVC {
    WelcomeVC()
  }
  func createAllCategoriesVC() -> TopMoviesVC {
    TopMoviesVC()
  }
  func createCategoryVC() -> MoviesCategoryVC {
    MoviesCategoryVC()
  }
  func createMovieVC() -> MovieVC {
    MovieVC()
  }
}
