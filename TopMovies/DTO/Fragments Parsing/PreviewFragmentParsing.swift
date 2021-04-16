//
//  PreviewFragmentParsing.swift
//  TopMovies
//
//  Created by Macbook Pro  on 07.04.2021.
//

import Foundation
import GraphQLAPI

extension MoviePreviewDTOWrapper {
  init?(fragment: MoviePreviewFragment?) {
    guard let fragment = fragment else { return nil }
    
    id = fragment.id
    title = fragment.title
    overview = fragment.overview
    releaseDate = fragment.releaseDate ?? ""
    isAdult = fragment.isAdult
    rating = fragment.rating
    poster = fragment.poster.flatMap(URL.init(string:))
    backdrop = fragment.backdrop.flatMap(URL.init(string:))
  }
}
