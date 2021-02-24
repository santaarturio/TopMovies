//
//  CategoryDTO.swift
//  TopMovies
//
//  Created by anikolaenko on 05.02.2021.
//

struct CategoryDTO: Decodable {
  var name: String!
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

extension CategoryDTO {
  var nextPage: Int? { page < totalPages ? page + 1 : nil }
}

extension MovieCategory {
  init(dto: CategoryDTO) {
    id = ID(value: dto.name)
    title = dto.name
    movies = dto.results.map{ Movie(dto: $0).id }
    page = dto.page
    totalPages = dto.totalPages
    totalResults = dto.totalResults
  }
}
