//
//  PaginatedOperationState.swift
//  TopMovies
//
//  Created by Macbook Pro  on 23.02.2021.
//

struct PaginatedOperationState<T, U> {
  let list: [T]
  let reload: EmptyRequestState
  let loadMore: EmptyRequestState
  let pageInfo: PageInfo
  
  enum PageInfo {
    case lastPage, next(U)
  }
}
