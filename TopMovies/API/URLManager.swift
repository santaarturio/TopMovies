//
//  URLManager.swift
//  TopMovies
//
//  Created by anikolaenko on 05.02.2021.
//

import Foundation

struct URLManager {
  func tmdbImageURL(for path: String?) -> URL? {
    guard let path = path else { return nil }
    return URL(string: "https://image.tmdb.org/t/p/w500" + path)
  }
}
