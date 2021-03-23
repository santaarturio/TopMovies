//
//  MoviePreview.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import Foundation

struct MoviePreview: Hashable, Equatable {
  let id: ID
  let adult: Bool
  let title: String
  let description: String
  let rating: Double
  let voteCount: Int
  let releaseDate: String
  let poster: URL?
  
  struct ID: Hashable {
    let value: String
  }
}