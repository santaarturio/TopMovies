//
//  MoviePreviewDTOWrapper.swift
//  TopMovies
//
//  Created by Macbook Pro  on 03.04.2021.
//

import Foundation

struct MoviePreviewDTOWrapper {
  var id: Int
  var title: String
  var overview: String?
  var releaseDate: String
  var isAdult: Bool
  var rating: Double
  var poster: URL?
  var backdrop: URL?
}

extension MoviePreview {
  init(dto: MoviePreviewDTOWrapper) {
    id = ID(value: String(dto.id))
    adult = dto.isAdult
    title = dto.title
    description = dto.overview ?? L10n.App.Home.Movie.overview
    rating = dto.rating
    releaseDate = Date.prettyDate(from: dto.releaseDate)
    poster = dto.poster ?? dto.backdrop
  }
}
