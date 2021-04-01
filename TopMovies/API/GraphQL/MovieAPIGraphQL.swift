//
//  MovieAPIGraphQL.swift
//  TopMovies
//
//  Created by Macbook Pro  on 06.04.2021.
//

import Foundation
import GraphQLAPI

final class MovieAPIGraphQL: MovieAPIProtocol {
  // MARK: - All Categories
  func allMovieCategories(categoriesResult: @escaping (Result<[CategoryDTOWrapper], Error>) -> Void) {
    allMovieCategories(callBackQueue: DispatchQueue.defaultSerialQueue,
                       categoriesResult: categoriesResult)
  }
  func allMovieCategories(callBackQueue queue: DispatchQueue,
                          categoriesResult: @escaping (Result<[CategoryDTOWrapper], Error>) -> Void) {
    apollo.fetch(query: AllMovieCategoriesQuery()) { result in
      switch result {
      case let .success(response):
        if let fragment = response.data?.movies {
          categoriesResult(.success(MovieCategoryRequest
                                      .allCases
                                      .map { request -> CategoryDTOWrapper in
                                        .init(id: request.rawValue,
                                              title: CategoryDTO.name(by: request),
                                              fragment: fragment,
                                              request: request)
                                      }))
        }
      case let .failure(error):
        categoriesResult(.failure(error))
      }
    }
  }
  
  // MARK: - Category
  func category(request: MovieCategoryRequest,
                page: String?,
                categoryResult: @escaping (Result<CategoryDTOWrapper, Error>) -> Void) {
    switch request {
    case .nowPlaying:
      apollo.fetch(query: page != nil ?
                    NowPlayingCategoryQuery(cursor: page!) : NowPlayingCategoryQuery())
      { [unowned self] result in
        switch result {
        case let .success(response):
          if let fragment = response.data?.movies.nowPlaying.fragments.movieCategoryFragment {
            categoryResult(.success(categoryWrapper(by: fragment, and: request)))
          }
        case let .failure(error):
          categoryResult(.failure(error))
        }
      }
    case .popular:
      apollo.fetch(query: page != nil ?
                    PopularCategoryQuery(cursor: page!) : PopularCategoryQuery())
      { [unowned self] result in
        switch result {
        case let .success(response):
          if let fragment = response.data?.movies.popular.fragments.movieCategoryFragment {
            categoryResult(.success(categoryWrapper(by: fragment, and: request)))
          }
        case let .failure(error):
          categoryResult(.failure(error))
        }
      }
    case .topRated:
      apollo.fetch(query: page != nil ?
                    TopRatedCategoryQuery(cursor: page!) : TopRatedCategoryQuery())
      { [unowned self] result in
        switch result {
        case let .success(response):
          if let fragment = response.data?.movies.topRated.fragments.movieCategoryFragment {
            categoryResult(.success(categoryWrapper(by: fragment, and: request)))
          }
        case let .failure(error):
          categoryResult(.failure(error))
        }
      }
    case .upcoming:
      apollo.fetch(query: page != nil ?
                    UpcomingCategoryQuery(cursor: page!) : UpcomingCategoryQuery())
      { [unowned self] result in
        switch result {
        case let .success(response):
          if let fragment = response.data?.movies.upcoming.fragments.movieCategoryFragment {
            categoryResult(.success(categoryWrapper(by: fragment, and: request)))
          }
        case let .failure(error):
          categoryResult(.failure(error))
        }
      }
    }
  }
  private func categoryWrapper(by fragment: MovieCategoryFragment,
                               and request: MovieCategoryRequest) -> CategoryDTOWrapper {
    .init(id: request.rawValue,
          title: CategoryDTO.name(by: request),
          fragment: fragment)
  }
  
  // MARK: - Movie
  func movie(id: MoviePreview.ID,
             movieResult: @escaping (Result<MovieDTOWrapper, Error>) -> Void) {
    guard let id = Int(id.value) else { return }
    apollo.fetch(query: MovieQuery(id: id)) { result in
      switch result {
      case let .success(response):
        if let detailsFragment = response.data?.movies.movie.details.fragments.movieDetailsFragment {
          movieResult(.success(.init(fragment: detailsFragment)))
        }
      case let .failure(error):
        movieResult(.failure(error))
      }
    }
  }
}
