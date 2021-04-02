//
//  CategoryDTO.swift
//  TopMovies
//
//  Created by anikolaenko on 05.02.2021.
//

struct CategoryDTOWrapper {
  var id: String
  var name: String
  var dto: CategoryDTO
}

struct CategoryDTO: Decodable {
  let page: Int
  let results: [MoviePreviewDTO]
  let totalPages, totalResults: Int
  
  enum CodingKeys: String, CodingKey {
    case page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

extension CategoryDTO {
  var nextPage: Int? { page < totalPages ? page + 1 : nil }
}

extension MovieCategory {
  init(dtoWrapper: CategoryDTOWrapper) {
    id = ID(value: dtoWrapper.id)
    title = dtoWrapper.name
  }
}
