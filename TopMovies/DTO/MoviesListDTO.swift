//
//  MoviesListDTO.swift
//  TopMovies
//
//  Created by anikolaenko on 05.02.2021.
//

struct MoviesListDTO: Decodable {
  var name: String?
  let page: Int
  let results: [MovieDTO]
  let totalPages, totalResults: Int
  
  enum CodingKeys: String, CodingKey {
    case name
    case page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

extension MovieCategory {
  init(dto: MoviesListDTO) {
    id = ID(value: "\(dto.name ?? "No Category Name")")
    title = dto.name ?? "No Category Name"
    movies = dto.results.map{ Movie(dto: $0).id }
  }
}
