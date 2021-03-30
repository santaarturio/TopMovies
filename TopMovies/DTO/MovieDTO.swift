//
//  MovieDTO.swift
//  TopMovies
//
//  Created by Macbook Pro  on 23.03.2021.
//

import Foundation

// MARK: - MovieDTO
struct MovieDTO: Decodable {
  let adult: Bool
  let backdropPath: String?
  let budget: Int
  let genres: [GenreDTO]
  let id: Int
  let overview: String?
  let posterPath: String?
  let productionCompanies: [ProductionCompanyDTO]
  let releaseDate: String
  let runtime: Int?
  let tagline: String?
  let status, title: String
  let voteAverage: Double
  let voteCount: Int
  
  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case budget, genres, id, overview
    case posterPath = "poster_path"
    case productionCompanies = "production_companies"
    case releaseDate = "release_date"
    case runtime, status, tagline, title
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}

// MARK: - Genre
struct GenreDTO: Decodable {
  let name: String
}

// MARK: - ProductionCompany
struct ProductionCompanyDTO: Decodable {
  let logoPath: String?
  let name, originCountry: String
  
  enum CodingKeys: String, CodingKey {
    case logoPath = "logo_path"
    case name
    case originCountry = "origin_country"
  }
}

// MARK: - DTO Parsing -
extension ProductionCompany {
  init(dto: ProductionCompanyDTO) {
    name = dto.name
    logo = URLManager.companyLogoURL(for: dto.logoPath)
    country = dto.originCountry
  }
}
extension Movie {
  init(dto: MovieDTO) {
    id = .init(value: String(dto.id))
    adult = dto.adult
    title = dto.title
    description = dto.overview ?? L10n.App.MovieDetail.overview
    budget = dto.budget
    genres = dto.genres.map(\.name)
    productionCompanies = dto.productionCompanies.map(ProductionCompany.init(dto: ))
    rating = dto.voteAverage
    voteCount = dto.voteCount
    runtime = dto.runtime ?? 0
    tagline = dto.tagline ?? ""
    releaseDate = Date.prettyDate(from: dto.releaseDate)
    status = dto.status
    poster = URLManager.moviePosterURL(for: dto.posterPath ?? dto.backdropPath)
  }
}
