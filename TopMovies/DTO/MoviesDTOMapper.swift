//
//  MoviesDTOMapper.swift
//  TopMovies
//
//  Created by anikolaenko on 05.02.2021.
//

import Foundation

struct MoviesDTOMapper {
    static func map(_ dto: MovieDTO) -> Movie {
        Movie(id: .init(value: dto.id),
              adult: dto.adult,
              title: dto.title,
              description: dto.overview,
              rating: dto.vote_average,
              poster: URLManager.moviePosterURLFor(path: dto.poster_path))
    }
}
