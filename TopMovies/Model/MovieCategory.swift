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
  
  struct ID: Hashable {
    let value: String
  }
}
