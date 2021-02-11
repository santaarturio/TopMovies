//
//  MoviesListDTO.swift
//  TopMovies
//
//  Created by anikolaenko on 05.02.2021.
//

import Foundation

struct MoviesListDTO: Decodable {
  let averageRating: Double
  let backdropPath: String
  let comments: [String: String?]
  let listDescription: String
  let id: Int
  let name: String
  let objectIDS: [String: String?]
  let page: Int
  let posterPath: String
  let results: [MovieDTO]
  let revenue, runtime: Int
  let sortBy: String
  let totalPages, totalResults: Int
  
  enum CodingKeys: String, CodingKey {
    case averageRating = "average_rating"
    case backdropPath = "backdrop_path"
    case comments
    case listDescription = "description"
    case id
    case name
    case objectIDS = "object_ids"
    case page
    case posterPath = "poster_path"
    case results, revenue, runtime
    case sortBy = "sort_by"
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

extension MovieCategory {
  init(dto: MoviesListDTO) {
    id = ID(value: "\(dto.id)")
    title = dto.name
    description = dto.listDescription
    movies = dto.results.map{ Movie(dto: $0) }
  }
}
