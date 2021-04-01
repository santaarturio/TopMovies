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
  let rating: Double
  
  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case budget, genres, id, overview
    case posterPath = "poster_path"
    case productionCompanies = "production_companies"
    case releaseDate = "release_date"
    case runtime, status, tagline, title
    case rating = "vote_average"
  }
}

// MARK: - Genre
struct GenreDTO: Decodable {
  let name: String
}
extension GenreDTOWrapper {
  init(restDTO: GenreDTO) {
    name = restDTO.name
  }
}

// MARK: - ProductionCompany
struct ProductionCompanyDTO: Decodable {
  let logoPath: String?
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case logoPath = "logo_path"
    case name
  }
}
extension ProductionCompanyDTOWrapper {
  init(dto: ProductionCompanyDTO) {
    let urlManager = URLManager()
    
    name = dto.name
    logo = urlManager.tmdbImageURL(for: dto.logoPath)
  }
}

// MARK: - MovieDTOWrapper
extension MovieDTOWrapper {
  init(dto: MovieDTO) {
    let urlManager = URLManager()
    
    isAdult = dto.adult
    backdrop = urlManager.tmdbImageURL(for: dto.backdropPath)
    budget = dto.budget
    genres = dto.genres.map(GenreDTOWrapper.init(restDTO:))
    id = dto.id
    overview = dto.overview
    poster = urlManager.tmdbImageURL(for: dto.posterPath)
    productionCompanies = dto.productionCompanies.map(ProductionCompanyDTOWrapper.init(dto:))
    releaseDate = dto.releaseDate
    runtime = dto.runtime
    tagline = dto.tagline
    status = dto.status
    title = dto.title
    rating = dto.rating
  }
}
