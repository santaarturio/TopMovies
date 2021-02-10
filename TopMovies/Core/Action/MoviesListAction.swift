//
//  MoviesListAction.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import ReSwift

enum MoviesListAction: Action {
  case request
  case downloading
  case completed(categoryName: String, movies: [Movie])
  case failed(error: Error)
}
