//
//  MockMainState.swift
//  TopMoviesTests
//
//  Created by anikolaenko on 11.03.2021.
//

@testable import TopMovies

// MARK: - All Categories
let mockMainStateAllCategories
  = MainState(configurationState: .initial,
              appFlowState: .foreground,
              movieCategoriesState: .init(relational: [:], categoriesList: .requested),
              categoriesPaginationState: .init(paginated: [:]),
              moviesState: .init(relational: [:]))

let mockMainStateAllCategoriesCompleted
  = MainState(configurationState: .initial,
              appFlowState: .foreground,
              movieCategoriesState: .init(relational: [mockMovieCategory.id: mockMovieCategory,
                                                       mockMovieCategory2.id: mockMovieCategory2],
                                          categoriesList: .completed(data: [mockMovieCategory.id, mockMovieCategory2.id])),
              categoriesPaginationState: .init(paginated: [mockMovieCategory.id: .init(list: [mockMovie.id],
                                                                                       reload: .initial,
                                                                                       loadMore: .initial,
                                                                                       pageInfo: .next(10)),
                                                           mockMovieCategory2.id: .init(list: [mockMovie2.id],
                                                                                        reload: .initial,
                                                                                        loadMore: .initial,
                                                                                        pageInfo: .next(10))]),
              moviesState: .init(relational: [mockMovie.id: mockMovie,
                                              mockMovie2.id: mockMovie2]))

// MARK: - Some Category
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

let mockMainStateSomeCategoryCompleted
  = MainState(configurationState: .initial,
              appFlowState: .foreground,
              movieCategoriesState: .init(relational: [mockMovieCategory.id: mockMovieCategory],
                                          categoriesList: .completed(data: [mockMovieCategory.id])),
              categoriesPaginationState: .init(paginated: [mockMovieCategory.id: .init(list: [mockMovie.id],
                                                                                       reload: .initial,
                                                                                       loadMore: .initial,
                                                                                       pageInfo: .next(10))]),
              moviesState: .init(relational: [mockMovie.id: mockMovie]))

// MARK: - Some Movie
let mockMainStateSomeMovieDetailRequested
  = MainState(configurationState: .initial,
              appFlowState: .foreground,
              movieCategoriesState: .init(relational: [:], categoriesList: .initial),
              categoriesPaginationState: .init(paginated: [:]),
              moviesState: .init(detailInfo: [mockMovie.id: .requested],
                                 relational: [:]))

let mockMainStateSomeMovieDetailCompleted
  = MainState(configurationState: .initial,
              appFlowState: .foreground,
              movieCategoriesState: .init(relational: [mockMovieCategory.id: mockMovieCategory],
                                          categoriesList: .completed(data: [mockMovieCategory.id])),
              categoriesPaginationState: .init(paginated: [:]),
              moviesState: .init(detailInfo: [mockMovie.id: .updated],
                                 relational: [mockMovie.id: mockMovie]))
