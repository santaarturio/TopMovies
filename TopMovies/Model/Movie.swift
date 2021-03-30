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
  let releaseDate: Date
  let status: String
  let poster: URL?
}

struct ProductionCompany: Equatable {
  let name: String
  let logo: URL?
  let country: String
}

extension Movie {
  init?(preview: MoviePreview?) {
    guard let preview = preview else { return nil }
    id = preview.id
    adult = preview.adult
    title = preview.title
    description = preview.description
    budget = 0
    genres = []
    productionCompanies = []
    rating = preview.rating
    voteCount = preview.voteCount
    runtime = 0
    tagline = ""
    releaseDate = preview.releaseDate
    status = ""
    poster = preview.poster
  }
}

extension Movie: Defaultable {
  static var defaultValue: Movie {
    Movie(id: .init(value: ""),
          adult: false,
          title: "",
          description: "",
          budget: 0,
          genres: [],
          productionCompanies: [],
          rating: 0,
          voteCount: 0,
          runtime: 0,
          tagline: "",
          releaseDate: .init(),
          status: "",
          poster: nil)
  }
}
