//
//  MovieCategory.swift
//  TopMovies
//
//  Created by anikolaenko on 11.02.2021.
//

import Foundation

struct MovieCategoryWrapper {
  let category: MovieCategory
  let next: String?
}

struct MovieCategory: Equatable {
  let id: ID
  let title: String
  
  struct ID: Hashable {
      let value: String
  }
}
