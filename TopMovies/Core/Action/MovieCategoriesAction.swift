//
//  MovieCategoriesAction.swift
//  TopMovies
//
//  Created by anikolaenko on 11.02.2021.
//

import ReSwift

enum MovieCategoriesAction: Action {
  case request
  case downloading
  case completed(categoriesDTO: [MoviesListDTO])
  case failed(error: Error)
}
