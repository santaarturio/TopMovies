//
//  CategoryPageState.swift
//  TopMovies
//
//  Created by Macbook Pro  on 17.02.2021.
//

import Foundation

struct CategoryPageState {
  let currentPage, totalPages, totalResults: Int
  private var hasNext: Bool { return currentPage < totalPages }
  var next: Int? { hasNext ? currentPage + 1 : nil }
}

extension CategoryPageState {
  init(category: MovieCategory) {
    currentPage = category.page
    totalPages = category.totalPages
    totalResults = category.totalResults
  }
}
