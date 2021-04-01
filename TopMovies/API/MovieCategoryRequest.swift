//
//  MovieCategoryRequest.swift
//  TopMovies
//
//  Created by Macbook Pro  on 17.02.2021.
//

import Foundation

enum MovieCategoryRequest: String, CaseIterable {
  case nowPlaying = "now_playing"
  case popular = "popular"
  case topRated = "top_rated"
  case upcoming = "upcoming"
}

extension CategoryDTO {
  static func name(by request: MovieCategoryRequest) -> String {
    switch request {
    case .nowPlaying: return L10n.App.Category.Name.nowPlaying
    case .popular: return L10n.App.Category.Name.popular
    case .topRated: return L10n.App.Category.Name.topRated
    case .upcoming: return L10n.App.Category.Name.upcoming
    }
  }
}

extension MoviesDBTarget {
  init(category: MovieCategoryRequest, page: Int = 1) {
    self = .category(id: .init(value: category.rawValue),
                     page: page)
  }
}
