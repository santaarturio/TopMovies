//
//  MovieCategory.swift
//  TopMovies
//
//  Created by anikolaenko on 11.02.2021.
//

import Foundation

struct MovieCategory {
  let id: ID
  let title: String
  let description: String
  let movies: [Movie.ID]
  
  struct ID: Hashable {
      let value: String
  }
}
