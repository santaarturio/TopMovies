//
//  URLManager.swift
//  TopMovies
//
//  Created by anikolaenko on 05.02.2021.
//

import Foundation

struct URLManager {
    static func moviePosterURLFor(path: String) -> URL? {
        URL(string: "https://image.tmdb.org/t/p/w500 + \(path)")
    }
}
