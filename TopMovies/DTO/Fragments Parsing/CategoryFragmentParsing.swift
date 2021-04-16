//
//  CategoryFragmentParsing.swift
//  TopMovies
//
//  Created by Macbook Pro  on 08.04.2021.
//

import Foundation
import GraphQLAPI

extension CategoryDTOWrapper {
  init(id: String, title: String, fragment: MovieCategoryFragment) {
    self.id = id
    self.title = title
    movies = fragment.edges?
                .compactMap { MoviePreviewDTOWrapper(fragment: $0?.node?.fragments.moviePreviewFragment) } ?? []
    next = fragment.edges?.last?.map(\.cursor)
  }
}

extension CategoryDTOWrapper {
  init(id: String, title: String, fragment: AllMovieCategoriesQuery.Data.Movie, request: MovieCategoryRequest) {
    
    let fragment: MovieCategoryFragment = {
      switch request {
      case .nowPlaying:
        return fragment.nowPlaying.fragments.movieCategoryFragment
      case .topRated:
        return fragment.topRated.fragments.movieCategoryFragment
      case .upcoming:
        return fragment.upcoming.fragments.movieCategoryFragment
      case .popular:
        return fragment.popular.fragments.movieCategoryFragment
      }
    }()
    
    self.init(id: id, title: title, fragment: fragment)
  }
}
