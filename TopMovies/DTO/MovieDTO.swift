//
//  MovieDTO.swift
//  TopMovies
//
//  Created by anikolaenko on 05.02.2021.
//

struct MovieDTO: Decodable {
  let adult: Bool
  let backdropPath: String
  let genreIds: [Int]
  let id: Int
  let originalTitle, overview: String
  let popularity: Double
  let posterPath, releaseDate, title: String
  let video: Bool
  let voteAverage: Double
  let voteCount: Int
  
  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case genreIds = "genre_ids"
    case id
    case originalTitle = "original_title"
    case overview, popularity
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case title, video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}

extension Movie {
  init(dto: MovieDTO) {
    id = ID(value: String(dto.id))
    adult = dto.adult
    title = dto.title
    description = dto.overview
    rating = dto.voteAverage
    voteCount = dto.voteCount
    releaseDate = dto.releaseDate
    poster = URLManager.moviePosterURLFor(path: dto.posterPath)
  }
}
