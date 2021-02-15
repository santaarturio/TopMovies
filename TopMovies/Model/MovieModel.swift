//
//  MovieModel.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import Foundation

struct Movie {
  let id: ID
  let adult: Bool
  let title: String
  let description: String
  let rating: Double
  let poster: URL?
  
  struct ID: Hashable {
    let value: String
  }
}
