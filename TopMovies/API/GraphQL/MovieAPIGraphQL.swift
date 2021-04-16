//
//  MovieAPIGraphQL.swift
//  TopMovies
//
//  Created by Macbook Pro  on 06.04.2021.
//

import Foundation
import GraphQLAPI
import Apollo
import Overture

final class MovieAPIGraphQL: MovieAPIProtocol {
  private let apollo = ApolloClient.default
  
  // MARK: - All Categories
  func allMovieCategories(categoriesResult: @escaping (Result<[CategoryDTOWrapper], Error>) -> Void) {
    allMovieCategories(callBackQueue: DispatchQueue.defaultSerialQueue,
                       categoriesResult: categoriesResult)
  }
  func allMovieCategories(callBackQueue queue: DispatchQueue,
                          categoriesResult: @escaping (Result<[CategoryDTOWrapper], Error>) -> Void) {
    apollo.fetch(query: AllMovieCategoriesQuery()) { result in
      categoriesResult(
        result
          .flatMap(GraphQLResult.successfullResult(result:))
          .map(\.movies)
          .map { fragment -> [CategoryDTOWrapper] in
            MovieCategoryRequest
              .allCases
              .map { request -> CategoryDTOWrapper in
                .init(id: request.rawValue,
                      title: CategoryDTO.name(by: request),
                      fragment: fragment,
                      request: request)
              }
          }
      )
    }
  }
  
  // MARK: - Category
  func category(request: MovieCategoryRequest,
                page: String?,
                categoryResult: @escaping (Result<CategoryDTOWrapper, Error>) -> Void) {
    switch request {
    case .nowPlaying:
      apollo.fetch(query: NowPlayingCategoryQuery(cursor: page))
      { result in
        categoryResult(
          result
            .flatMap(GraphQLResult.successfullResult(result:))
            .map(\.movies.nowPlaying.fragments.movieCategoryFragment)
            .map { CategoryDTOWrapper(fragment: $0, request: request) }
        )
      }
    case .popular:
      apollo.fetch(query: PopularCategoryQuery(cursor: page))
      { result in
        categoryResult(
          result
            .flatMap(GraphQLResult.successfullResult(result:))
            .map(\.movies.popular.fragments.movieCategoryFragment)
            .map { CategoryDTOWrapper(fragment: $0, request: request) }
        )
      }
    case .topRated:
      apollo.fetch(query: TopRatedCategoryQuery(cursor: page))
      { result in
        categoryResult(
          result
            .flatMap(GraphQLResult.successfullResult(result:))
            .map(\.movies.topRated.fragments.movieCategoryFragment)
            .map { CategoryDTOWrapper(fragment: $0, request: request) }
        )
      }
    case .upcoming:
      apollo.fetch(query: UpcomingCategoryQuery(cursor: page))
      { result in
        categoryResult(
          result
            .flatMap(GraphQLResult.successfullResult(result:))
            .map(\.movies.upcoming.fragments.movieCategoryFragment)
            .map { CategoryDTOWrapper(fragment: $0, request: request) }
        )
      }
    }
  }
  
  // MARK: - Movie
  func movie(id: MoviePreview.ID,
             movieResult: @escaping (Result<MovieDTOWrapper, Error>) -> Void) {
    guard let id = Int(id.value) else { return }
    apollo.fetch(query: MovieQuery(id: id)) { result in
      movieResult(
        result
          .flatMap(GraphQLResult.successfullResult(result:))
          .map(\.movies.movie.details.fragments.movieDetailsFragment)
          .map(MovieDTOWrapper.init(fragment:))
      )
    }
  }
}

private extension CategoryDTOWrapper {
  init(fragment: MovieCategoryFragment, request: MovieCategoryRequest) {
    self.init(id: request.rawValue,
              title: CategoryDTO.name(by: request),
              fragment: fragment)
  }
}
