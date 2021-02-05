//
//  MoviesListDTO.swift
//  TopMovies
//
//  Created by anikolaenko on 05.02.2021.
//

import Foundation

struct MoviesListDTO: Decodable {
    let average_rating: Double
    let backdrop_path: String
    let comments: [String: String?]
    let description: String
    let id: Int
    let name: String
    let object_ids: [String: String?]
    let page: Int
    let poster_path: String
    let results: [MovieDTO]
    let revenue, runtime: Int
    let sort_by: String
    let total_pages, total_results: Int
}
