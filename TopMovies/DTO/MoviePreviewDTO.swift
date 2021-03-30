//
//  MoviePreviewDTO.swift
//  TopMovies
//
//  Created by anikolaenko on 05.02.2021.
//

import Foundation

struct MoviePreviewDTO: Decodable {
  let adult: Bool
  let backdropPath: String?
  let id: Int
  let overview: String?
  let posterPath: String?
  let releaseDate, title: String
  let voteAverage: Double
  let voteCount: Int
  
  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case id
    case overview
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case title
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}

extension MoviePreview {
  init(dto: MoviePreviewDTO) {
    id = ID(value: String(dto.id))
    adult = dto.adult
    title = dto.title
    description = dto.overview ?? L10n.App.Home.Movie.overview
    rating = dto.voteAverage
    voteCount = dto.voteCount
    releaseDate = Date.prettyDate(from: dto.releaseDate) 
    poster = URLManager.moviePosterURL(for: dto.posterPath ?? dto.backdropPath)
  }
}
