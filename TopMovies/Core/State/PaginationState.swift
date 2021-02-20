//
//  PaginatedState.swift
//  TopMovies
//
//  Created by Macbook Pro  on 19.02.2021.
//

import ReSwift

enum EmptyRequestState {
  case initial
  case requested
  case downloading
  case failed(error: Error)
}
struct PaginatedOperationState<T, U> {
  let list: [T]
  let reload: EmptyRequestState
  let loadMore: EmptyRequestState
  let pageInfo: PageInfo
  
  enum PageInfo {
    case initial, lastPage, next(U)
  }
}

struct PaginationState: StateType {
  typealias CategoryState = PaginatedOperationState<Movie.ID, Int>
  
  let paginated: [MovieCategory.ID: CategoryState]
}

// MARK: - PaginationState Reducer -
extension PaginationState {
  static func reduce(action: Action, state: PaginationState) -> PaginationState {
    switch action {
    case let movieCategoriesAction as MovieCategoriesAction:
      return reduceIfMovieCategoriesAction(action: movieCategoriesAction, state: state)
    case let requestAction as MoviesRequestAction:
      return reduceIfMoviesRequestAction(action: requestAction, state: state)
    case let responseAction as MoviesResponseAction:
      return reduceIfMoviesResponseAction(action: responseAction, state: state)
    default: return state
    }
  }
  // MARK: - MovieCategoriesAction
  private static func reduceIfMovieCategoriesAction(action: MovieCategoriesAction, state: PaginationState)
  -> PaginationState {
    switch action {
    case let .completed(_,_, relational):
      return PaginationState(paginated: relational.mapValues { CategoryState.init(list: $0,
                                                                                  reload: .initial,
                                                                                  loadMore: .initial,
                                                                                  pageInfo: .next(2)) })
    default: return state
    }
  }
  // MARK: - MoviesRequestAction
  private static func reduceIfMoviesRequestAction(action: MoviesRequestAction, state: PaginationState)
  -> PaginationState {
    let categoryId = action.categoryId
    var newPaginated = state.paginated
    switch action.requestType {
    case .reload:
      newPaginated.updateValue(.init(list: state.paginated[categoryId]?.list ?? [],
                                     reload: .requested,
                                     loadMore: .initial,
                                     pageInfo: state.paginated[categoryId]?.pageInfo ?? .initial),
                               forKey: categoryId)
      return PaginationState(paginated: newPaginated)
    case .loadMore:
      newPaginated.updateValue(.init(list: state.paginated[categoryId]?.list ?? [],
                                     reload: .initial,
                                     loadMore: .requested,
                                     pageInfo: state.paginated[categoryId]?.pageInfo ?? .initial),
                               forKey: categoryId)
      return PaginationState(paginated: newPaginated)
    }
  }
  // MARK: - MoviesResponseAction
  private static func reduceIfMoviesResponseAction(action: MoviesResponseAction, state: PaginationState)
  -> PaginationState {
    let categoryId = action.categoryId
    var newPaginated = state.paginated
    switch action.responseType {
    case .downloading:
      newPaginated.updateValue(.init(list: state.paginated[categoryId]?.list ?? [],
                                     reload: action.requestedType == MoviesRequestAction.RequestType.reload ?
                                      .downloading : .initial,
                                     loadMore: action.requestedType == MoviesRequestAction.RequestType.loadMore ?
                                      .downloading : .initial,
                                     pageInfo: state.paginated[categoryId]?.pageInfo ?? .initial),
                               forKey: categoryId)
      return PaginationState(paginated: newPaginated)
    case .completed:
      var listIfLoadMore = newPaginated[categoryId]?.list ?? []
      listIfLoadMore.append(contentsOf: action.list.map(\.id))
      newPaginated.updateValue(.init(list: action.requestedType == MoviesRequestAction.RequestType.reload ?
                                      action.list.map(\.id) : listIfLoadMore,
                                     reload: .initial,
                                     loadMore: .initial,
                                     pageInfo: action.nextPage != nil ?
                                      .next(action.nextPage!) : .lastPage),
                               forKey: categoryId)
      return PaginationState(paginated: newPaginated)
    case let .failed(error):
      newPaginated.updateValue(.init(list: state.paginated[categoryId]?.list ?? [],
                                     reload: action.requestedType == MoviesRequestAction.RequestType.reload ?
                                      .failed(error: error) : .initial,
                                     loadMore: action.requestedType == MoviesRequestAction.RequestType.loadMore ?
                                      .failed(error: error) : .initial,
                                     pageInfo: state.paginated[categoryId]?.pageInfo ?? .initial),
                               forKey: categoryId)
      return PaginationState(paginated: newPaginated)
    }
  }
}
