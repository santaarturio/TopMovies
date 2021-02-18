//
//  CategoryPageState.swift
//  TopMovies
//
//  Created by Macbook Pro  on 17.02.2021.
//

import Foundation

struct CategoryPageState {
  let currentPage, totalPages, totalResults: Int
  var next: Int? { currentPage < totalPages ? currentPage + 1 : nil }
}

extension CategoryPageState {
  init(category: MovieCategory) {
    currentPage = category.page
    totalPages = category.totalPages
    totalResults = category.totalResults
  }
}
