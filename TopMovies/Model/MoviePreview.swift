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
  let releaseDate: Date
  let poster: URL?
  
  struct ID: Hashable {
    let value: String
  }
}

extension MoviePreview {
  init(movie: Movie) {
    id = movie.id
    adult = movie.adult
    title = movie.title
    description = movie.description
    rating = movie.rating
    voteCount = movie.voteCount
    releaseDate = movie.releaseDate
    poster = movie.poster
  }
}
