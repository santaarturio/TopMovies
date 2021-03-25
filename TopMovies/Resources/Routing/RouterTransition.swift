//
//  RouterTransition.swift
//  TopMovies
//
//  Created by Macbook Pro  on 19.03.2021.
//

enum RouteType {
  case allCategories
  case category(_ categoryId: MovieCategory.ID)
  case movie(_ movieId: MoviePreview.ID)
}
