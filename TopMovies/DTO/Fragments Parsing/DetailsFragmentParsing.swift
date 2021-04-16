//
//  DetailsFragmentParsing.swift
//  TopMovies
//
//  Created by Macbook Pro  on 07.04.2021.
//

import Foundation
import GraphQLAPI

extension MovieDTOWrapper {
  init(fragment: MovieDetailsFragment) {
    id = fragment.id
    title = fragment.title
    overview = fragment.overview
    releaseDate = fragment.releaseDate ?? ""
    isAdult = fragment.isAdult
    rating = fragment.rating
    poster = fragment.poster.flatMap(URL.init(string:))
    backdrop = fragment.backdrop.flatMap(URL.init(string:))
    budget = fragment.budget ?? 0
    runtime = fragment.runtime
    tagline = fragment.tagline
    status = fragment.status.rawValue
    genres = fragment.genres.map(\.name).map(GenreDTOWrapper.init(name:))
    productionCompanies = fragment.productionCompanies
      .map { ProductionCompanyDTOWrapper(name: $0.name,
                                         logo: $0.logo.flatMap(URL.init(string:))) }
  }
}
