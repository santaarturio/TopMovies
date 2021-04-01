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
  let rating: Double
  
  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case id
    case overview
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case title
    case rating = "vote_average"
  }
}

extension MoviePreviewDTOWrapper {
  init(dto: MoviePreviewDTO) {
    let urlManager = URLManager()
    
    id = dto.id
    title = dto.title
    overview = dto.overview
    releaseDate = dto.releaseDate
    isAdult = dto.adult
    rating = dto.rating
    poster = urlManager.tmdbImageURL(for: dto.posterPath)
    backdrop = urlManager.tmdbImageURL(for: dto.backdropPath)
  }
}
