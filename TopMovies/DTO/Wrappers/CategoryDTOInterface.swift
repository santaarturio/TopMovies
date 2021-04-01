//
//  CategoryDTOWrapper.swift
//  TopMovies
//
//  Created by Macbook Pro  on 03.04.2021.
//

struct CategoryDTOWrapper {
  var id: String
  var title: String
  var movies: [MoviePreviewDTOWrapper]
  var next: String?
}

extension MovieCategory {
  init(dto: CategoryDTOWrapper) {
    id = ID(value: dto.id)
    title = dto.title
  }
}
