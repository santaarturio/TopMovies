//
//  MockMainState.swift
//  TopMoviesTests
//
//  Created by anikolaenko on 11.03.2021.
//

@testable import TopMovies

let mockMainStateAllCategories
  = MainState(configurationState: .initial,
              appFlowState: .foreground,
              movieCategoriesState: .init(relational: [:], categoriesList: .requested),
              categoriesPaginationState: .init(paginated: [:]),
              moviesState: .init(relational: [:]))

let mockMainStateSomeCategoryReload
  = MainState(configurationState: .initial,
              appFlowState: .foreground,
              movieCategoriesState: .init(relational: [:], categoriesList: .initial),
              categoriesPaginationState: .init(paginated: [mockMovieCategory.id: .init(list: [],
                                                                                       reload: .requested,
                                                                                       loadMore: .initial,
                                                                                       pageInfo: .next(10))]),
              moviesState: .init(relational: [:]))

let mockMainStateSomeCategoryLoadMore
  = MainState(configurationState: .initial,
              appFlowState: .foreground,
              movieCategoriesState: .init(relational: [:], categoriesList: .initial),
              categoriesPaginationState: .init(paginated: [mockMovieCategory.id: .init(list: [],
                                                                                       reload: .initial,
                                                                                       loadMore: .requested,
                                                                                       pageInfo: .next(10))]),
              moviesState: .init(relational: [:]))
