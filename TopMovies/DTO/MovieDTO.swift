//
//  MovieDTO.swift
//  TopMovies
//
//  Created by Macbook Pro  on 23.03.2021.
//

// MARK: - MovieDTO
struct MovieDTO: Decodable {
  let adult: Bool
  let backdropPath: String?
  let budget: Int
  let genres: [GenreDTO]
  let homepage: String
  let id: Int
  let imdbID, originalLanguage, originalTitle: String
  let overview: String?
  let popularity: Double
  let posterPath: String?
  let productionCompanies: [ProductionCompanyDTO]
  let productionCountries: [ProductionCountryDTO]
  let releaseDate: String
  let revenue, runtime: Int
  let status, tagline, title: String
  let video: Bool
  let voteAverage: Double
  let voteCount: Int
  
  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case budget, genres, homepage, id
    case imdbID = "imdb_id"
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview, popularity
    case posterPath = "poster_path"
    case productionCompanies = "production_companies"
    case productionCountries = "production_countries"
    case releaseDate = "release_date"
    case revenue, runtime
    case status, tagline, title, video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}

// MARK: - Genre
struct GenreDTO: Decodable {
  let id: Int
  let name: String
}

// MARK: - ProductionCompany
struct ProductionCompanyDTO: Decodable {
  let id: Int
  let logoPath: String?
  let name, originCountry: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case logoPath = "logo_path"
    case name
    case originCountry = "origin_country"
  }
}

// MARK: - ProductionCountry
struct ProductionCountryDTO: Decodable {
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case name
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
    releaseDate = dto.releaseDate
    status = dto.status
    poster = URLManager.moviePosterURL(for: dto.posterPath ?? dto.backdropPath)
  }
}
