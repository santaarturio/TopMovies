//
//  CategoryVCConnector.swift
//  TopMovies
//
//  Created by Macbook Pro  on 17.02.2021.
//

import Foundation

final class CategoryVCConnector: BaseConnector<MoviesCategoryVCProps> {
  var categoryId: MovieCategory.ID?
  
  required init(updateProps: @escaping (MoviesCategoryVCProps) -> Void) {
    super.init(updateProps: updateProps)
  }
  convenience init(categoryId: MovieCategory.ID, updateProps: @escaping (MoviesCategoryVCProps) -> Void) {
    self.init(updateProps: updateProps)
    self.categoryId = categoryId
    mainStore.dispatch(RequestedMoviesListAction(categoryId: categoryId,
                                                 requestType: .loadMore))
  }
  
  override func newState(state: MainState) {
    guard
      let categoryId = categoryId,
      let categoryName = state.movieCategoriesState.relational[categoryId]?.title,
      let categoryState = state.categoriesPaginationState.paginated[categoryId]
    else { return }
    
    let props = MoviesCategoryVCProps(categoryName: categoryName,
                                      isReloadInProgress: categoryState.reload.isDownloading,
                                      isLoadMoreInProgress: categoryState.loadMore.isDownloading,
                                      movies: categoryState.list
                                        .compactMap {
                                          MovieTableViewCellProps(movie: state.moviesState.relational[$0])
                                        },
                                      actionReload: { mainStore
                                        .dispatch(RequestedMoviesListAction(categoryId: categoryId,
                                                                            requestType: .reload)) },
                                      actionLoadMore: { mainStore
                                        .dispatch(RequestedMoviesListAction(categoryId: categoryId,
                                                                            requestType: .loadMore)) })
    _updateProps(props)
  }
}
