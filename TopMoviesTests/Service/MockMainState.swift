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
              moviesUpdateState: .init(relational: [:]),
              moviesState: .init(previewsRelational: [:],
                                 moviesRelational: [:]))

let mockMainStateAllCategoriesCompleted
  = MainState(configurationState: .initial,
              appFlowState: .foreground,
              movieCategoriesState:
                .init(relational: [mockMovieCategory.id: mockMovieCategory,
                                   mockMovieCategory2.id: mockMovieCategory2],
                      categoriesList: .completed(data: [mockMovieCategory.id, mockMovieCategory2.id])),
              categoriesPaginationState:
                .init(paginated: [mockMovieCategory.id: .init(list: [mockMoviePreview.id],
                                                              reload: .initial,
                                                              loadMore: .initial,
                                                              pageInfo: .next(10)),
                                  mockMovieCategory2.id: .init(list: [mockMoviePreview2.id],
                                                               reload: .initial,
                                                               loadMore: .initial,
                                                               pageInfo: .next(10))]),
              moviesUpdateState: .init(relational: [:]),
              moviesState:
                .init(previewsRelational: [mockMoviePreview.id: mockMoviePreview,
                                           mockMoviePreview2.id: mockMoviePreview2],
                      moviesRelational: [:]))

// MARK: - Some Category
let mockMainStateSomeCategoryReload
  = MainState(configurationState: .initial,
              appFlowState: .foreground,
              movieCategoriesState: .init(relational: [:], categoriesList: .initial),
              categoriesPaginationState: .init(paginated: [mockMovieCategory.id:
                                                            .init(list: [],
                                                                  reload: .requested,
                                                                  loadMore: .initial,
                                                                  pageInfo: .next(10))]),
              moviesUpdateState: .init(relational: [:]),
              moviesState: .init(previewsRelational: [:],
                                 moviesRelational: [:]))

let mockMainStateSomeCategoryLoadMore
  = MainState(configurationState: .initial,
              appFlowState: .foreground,
              movieCategoriesState: .init(relational: [:], categoriesList: .initial),
              categoriesPaginationState: .init(paginated: [mockMovieCategory.id:
                                                            .init(list: [],
                                                                  reload: .initial,
                                                                  loadMore: .requested,
                                                                  pageInfo: .next(10))]),
              moviesUpdateState: .init(relational: [:]),
              moviesState: .init(previewsRelational: [:],
                                 moviesRelational: [:]))

let mockMainStateSomeCategoryCompleted
  = MainState(configurationState: .initial,
              appFlowState: .foreground,
              movieCategoriesState: .init(relational: [mockMovieCategory.id: mockMovieCategory],
                                          categoriesList: .completed(data: [mockMovieCategory.id])),
              categoriesPaginationState: .init(paginated: [mockMovieCategory.id:
                                                            .init(list: [mockMoviePreview.id],
                                                                  reload: .initial,
                                                                  loadMore: .initial,
                                                                  pageInfo: .next(10))]),
              moviesUpdateState: .init(relational: [:]),
              moviesState: .init(previewsRelational: [mockMoviePreview.id: mockMoviePreview],
                                 moviesRelational: [:]))

// MARK: - Some Movie
let mockMainStateSomeMovieUpdateRequested
  = MainState(configurationState: .initial,
              appFlowState: .foreground,
              movieCategoriesState: .init(relational: [:], categoriesList: .initial),
              categoriesPaginationState: .init(paginated: [:]),
              moviesUpdateState: .init(relational: [mockMoviePreview.id: .requested]),
              moviesState: .init(previewsRelational: [mockMoviePreview.id: mockMoviePreview],
                                 moviesRelational: [:]))

let mockMainStateSomeMovieUpdateCompleted
  = MainState(configurationState: .initial,
              appFlowState: .foreground,
              movieCategoriesState: .init(relational: [mockMovieCategory.id: mockMovieCategory],
                                          categoriesList: .completed(data: [mockMovieCategory.id])),
              categoriesPaginationState: .init(paginated: [:]),
              moviesUpdateState: .init(relational: [mockMoviePreview.id: .initial]),
              moviesState: .init(previewsRelational: [mockMoviePreview.id: mockMoviePreview],
                                 moviesRelational: [mockUpdatedMovie.id: mockUpdatedMovie]))
