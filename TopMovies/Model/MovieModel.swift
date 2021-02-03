//
//  MovieModel.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import Foundation

struct Movie {
    let id: ID
    let title: String
    let description: String
    let rating: Float
    let poster: URL?
    
    struct ID: Hashable {
        let value: String
    }
}
