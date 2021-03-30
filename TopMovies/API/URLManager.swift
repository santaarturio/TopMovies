//
//  URLManager.swift
//  TopMovies
//
//  Created by anikolaenko on 05.02.2021.
//

import Foundation

struct URLManager {
  static func moviePosterURL(for path: String?) -> URL? {
    guard let path = path else { return nil }
    return URL(string: "https://image.tmdb.org/t/p/w500" + path)
  }
  static func companyLogoURL(for path: String?) -> URL? {
    guard let path = path else { return nil }
    return URL(string: "https://image.tmdb.org/t/p/w500" + path)
  }
}
