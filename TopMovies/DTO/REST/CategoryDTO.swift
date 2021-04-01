//
//  CategoryDTO.swift
//  TopMovies
//
//  Created by anikolaenko on 05.02.2021.
//

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
  var nextPage: String? { page < totalPages ? "\(page + 1)" : nil }
}

extension CategoryDTOWrapper {
  init(id: String, title: String, dto: CategoryDTO) {
    self.id = id
    self.title = title
    movies = dto.results.map(MoviePreviewDTOWrapper.init(dto:))
    next = dto.nextPage
  }
}
