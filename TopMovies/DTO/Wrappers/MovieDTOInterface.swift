//
//  MovieDTOWrapper.swift
//  TopMovies
//
//  Created by Macbook Pro  on 03.04.2021.
//

import Foundation

struct MovieDTOWrapper {
  var isAdult: Bool
  var backdrop: URL?
  var budget: Int
  var genres: [GenreDTOWrapper]
  var id: Int
  var overview: String?
  var poster: URL?
  var productionCompanies: [ProductionCompanyDTOWrapper]
  var releaseDate: String
  var runtime: Int?
  var tagline: String?
  var status: String
  var title: String
  var rating: Double
}

extension Movie {
  init(dto: MovieDTOWrapper) {
    id = .init(value: String(dto.id))
    adult = dto.isAdult
    title = dto.title
    description = dto.overview ?? L10n.App.MovieDetail.overview
    budget = dto.budget
    genres = dto.genres.map(\.name)
    productionCompanies = dto.productionCompanies.map(ProductionCompany.init(dto:))
    rating = dto.rating
    runtime = dto.runtime ?? 0
    tagline = dto.tagline ?? ""
    releaseDate = Date.prettyDate(from: dto.releaseDate)
    status = dto.status
    poster = dto.poster ?? dto.backdrop
  }
}
