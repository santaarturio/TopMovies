//
//  MovieCategoryRequest.swift
//  TopMovies
//
//  Created by Macbook Pro  on 17.02.2021.
//

import Foundation

enum MovieCategoryRequest: String, CaseIterable {
  case nowPlaying = "Now Playing"
  case popular = "Popular"
  case topRated = "Top Rated"
  case upcoming = "Upcoming"
}

extension MovieTarget.RequestedCategory {
  init(category: MovieCategoryRequest, page: Int = 1) {
    switch category {
    case .nowPlaying: self = .nowPlaying(page: page)
    case .popular: self = .popular(page: page)
    case .topRated: self = .topRated(page: page)
    case .upcoming: self = .upcoming(page: page)
    }
  }
}
