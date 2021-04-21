//
//  CategoriesPaginationState.swift
//  TopMovies
//
//  Created by Macbook Pro  on 19.02.2021.
//

import ReSwift

struct CategoriesPaginationState: StateType {
  typealias CategoryState = PaginatedOperationState<MoviePreview.ID, String>
  let paginated: [MovieCategory.ID: CategoryState]
}

extension CategoriesPaginationState.CategoryState: Defaultable {
  static var defaultValue: CategoriesPaginationState.CategoryState {
    .init(list: [], reload: .initial, loadMore: .initial, pageInfo: .next("2"))
  }
}

extension CategoriesPaginationState: ANState {
  static var defaultValue: CategoriesPaginationState = .init(paginated: [:])
}

// MARK: - Reducer -
extension CategoriesPaginationState {
  static func reduce(action: ANAction, state: CategoriesPaginationState) -> CategoriesPaginationState {
    var newPaginated = state.paginated
    var categoryId: MovieCategory.ID
    var categoryPaginatedState: CategoryState {
      state.paginated[categoryId] ?? CategoryState.defaultValue
    }
    switch action {
    // MARK: - Reduce MovieCategoriesAction
    case let action as CompletedMovieCategoriesAction:
      let tupleArray = action.relational
        .map { (key: MovieCategory.ID, value: [MoviePreview.ID]) -> (MovieCategory.ID, CategoryState) in
          let newTuple =
            (key, CategoryState.init(list: value,
                                     reload: CategoryState.defaultValue.reload,
                                     loadMore: CategoryState.defaultValue.loadMore,
                                     pageInfo: .next(action.categories
                                                      .first(where: { (wrapper: MovieCategoryWrapper) -> Bool in
                                                        wrapper.category.id == key
                                                      })?.next ?? "")))
          return newTuple
        }
      return CategoriesPaginationState(
        paginated: Dictionary(uniqueKeysWithValues: tupleArray)
      )
    // MARK: - Reduce MoviesListActions
    case let action as RequestedPreviewsListAction:
      categoryId = action.categoryId
      newPaginated
        .updateValue(.init(list: categoryPaginatedState.list,
                           reload: action.requestType == .reload ?
                            .requested : categoryPaginatedState.reload,
                           loadMore: action.requestType == .loadMore ?
                            .requested : categoryPaginatedState.loadMore,
                           pageInfo: categoryPaginatedState.pageInfo),
                     forKey: categoryId)
      return CategoriesPaginationState(paginated: newPaginated)
    case let action as DownloadingPreviewsListAction:
      categoryId = action.categoryId
      newPaginated
        .updateValue(.init(list: categoryPaginatedState.list,
                           reload: action.requestType == .reload ?
                            .downloading : categoryPaginatedState.reload,
                           loadMore: action.requestType == .loadMore ?
                            .downloading : categoryPaginatedState.loadMore,
                           pageInfo: categoryPaginatedState.pageInfo),
                     forKey: categoryId)
      return CategoriesPaginationState(paginated: newPaginated)
    case let action as CompletedPreviewsListAction:
      categoryId = action.categoryId
      let newList = action.list.map(\.id)
      var listIfLoadMore = categoryPaginatedState.list
      listIfLoadMore.append(contentsOf: newList)
      newPaginated
        .updateValue(.init(list: action.requestType == .reload ? newList : listIfLoadMore,
                           reload: action.requestType == .reload ?
                            .initial : categoryPaginatedState.reload,
                           loadMore: action.requestType == .loadMore ?
                            .initial : categoryPaginatedState.loadMore,
                           pageInfo: action.nextPage
                            .map(CategoryState.PageInfo.next) ?? CategoryState.PageInfo.lastPage),
                     forKey: categoryId)
      return CategoriesPaginationState(paginated: newPaginated)
    case let action as FailedPreviewsListAction:
      categoryId = action.categoryId
      newPaginated
        .updateValue(.init(list: categoryPaginatedState .list,
                           reload: action.requestType == .reload ?
                            .failed(error: action.error) : categoryPaginatedState.reload,
                           loadMore: action.requestType == .loadMore ?
                            .failed(error: action.error) : categoryPaginatedState.loadMore,
                           pageInfo: categoryPaginatedState.pageInfo),
                     forKey: categoryId)
      return CategoriesPaginationState(paginated: newPaginated)
    default: return state
    }
  }
}
