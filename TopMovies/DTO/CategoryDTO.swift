//
//  CategoryDTO.swift
//  TopMovies
//
//  Created by anikolaenko on 05.02.2021.
//

struct CategoryDTO: Decodable {
  var id: String!
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

extension MovieCategory {
  init(dto: CategoryDTO) {
    id = ID(value: dto.id)
    title = dto.name
  }
}
