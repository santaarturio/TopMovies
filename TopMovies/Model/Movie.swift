//
//  Movie.swift
//  TopMovies
//
//  Created by Macbook Pro  on 23.03.2021.
//

import Foundation

struct Movie: Equatable {
  let id: MoviePreview.ID
  let adult: Bool
  let title: String
  let description: String
  let budget: Int
  let genres: [String]
  let productionCompanies: [ProductionCompany]
  let rating: Double
  let voteCount: Int
  let runtime: Int
  let tagline: String
  let releaseDate: String
  let status: String
  let poster: URL?
}

struct ProductionCompany: Equatable {
  let name: String
  let logo: URL?
  let country: String
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
