//
//  CategoryNameCoder.swift
//  TopMovies
//
//  Created by Macbook Pro  on 15.02.2021.
//

import Foundation

struct CategoryNameCoder {
  static func encodeName(for target: MovieTarget.Target) -> String {
    switch target {
    case .nowPlaying(page: _):
      return "Now Playing"
    case .popular(page: _):
      return "Popular"
    case .topRated(page: _):
      return "Top Rated"
    case .upcoming(page: _):
      return "Upcoming"
    }
  }
  static func decodeTarget(from name: String) -> MovieTarget.Target? {
    switch name {
    case "Now Playing":
      return .nowPlaying()
    case "Popular":
      return .popular()
    case "Top Rated":
      return .topRated()
    case "Upcoming":
      return .upcoming()
    default: return nil
    }
  }
}
