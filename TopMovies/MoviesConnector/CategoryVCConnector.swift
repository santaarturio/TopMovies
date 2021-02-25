//
//  CategoryVCConnector.swift
//  TopMovies
//
//  Created by Macbook Pro  on 17.02.2021.
//

import Foundation

class CategoryVCConnector: BaseConnector<MoviesCategoryVCProps> {
  var categoryId: MovieCategory.ID?
  var downloadedMovies: [Movie.ID] = []
  var isExistingMoviesConnected = false
  
  required init(updateProps: @escaping (MoviesCategoryVCProps) -> Void) {
    super.init(updateProps: updateProps)
  }
  convenience init(categoryId: MovieCategory.ID, updateProps: @escaping (MoviesCategoryVCProps) -> Void) {
    self.init(updateProps: updateProps)
    self.categoryId = categoryId
    mainStore.dispatch(RequestedMoviesListAction(categoryId: categoryId, requestType: .loadMore))
  }
  
  override func newState(state: MainState) {
    guard
      let categoryId = categoryId,
      let categoryName = state.movieCategoriesState.relational[categoryId]?.title,
      let moviesList = state.categoriesPaginationState.paginated[categoryId]?.list
    else { return }
    
    if !isExistingMoviesConnected {
      let props = MoviesCategoryVCProps(categoryId: categoryId,
                                        categoryName: categoryName,
                                        isReloadInProgress: false,
                                        isLoadMoreInProgress: false,
                                        moviesUsage: .reload,
                                        movies: moviesList
                                          .compactMap { MovieTableViewCellProps(movie:
                                                                                  state.moviesState.relational[$0]) })
      _updateProps(props)
      isExistingMoviesConnected = !isExistingMoviesConnected
      downloadedMovies = moviesList
    }
    checkIsDownloadingInProgress(categoryId: categoryId,
                                 categoryName: categoryName,
                                 categoryState: state.categoriesPaginationState.paginated[categoryId])
    if moviesList.count > downloadedMovies.count {
      var listDiff = moviesList
      listDiff.removeSubrange(0..<downloadedMovies.count)
      let props = MoviesCategoryVCProps(categoryId: categoryId,
                                        categoryName: categoryName,
                                        isReloadInProgress: false,
                                        isLoadMoreInProgress: false,
                                        moviesUsage: .loadMore,
                                        movies: listDiff
                                          .compactMap {
                                            MovieTableViewCellProps(movie: state.moviesState.relational[$0])
                                          })
      _updateProps(props)
      downloadedMovies.append(contentsOf: listDiff)
    }
    if moviesList.count < downloadedMovies.count {
      let props = MoviesCategoryVCProps(categoryId: categoryId,
                                        categoryName: categoryName,
                                        isReloadInProgress: false,
                                        isLoadMoreInProgress: false,
                                        moviesUsage: .reload,
                                        movies: moviesList
                                          .compactMap {
                                            MovieTableViewCellProps(movie: state.moviesState.relational[$0])
                                          })
      downloadedMovies = moviesList
      _updateProps(props)
    }
  }
  
  private func checkIsDownloadingInProgress(categoryId: MovieCategory.ID,
                                            categoryName: String,
                                            categoryState: CategoriesPaginationState.CategoryState?) {
    var isReloadInProgress = false
    var isLoadMoreInProgress = false
    if case .downloading = categoryState?.reload {
      isReloadInProgress = true
    }
    if case .downloading = categoryState?.loadMore {
      isLoadMoreInProgress = true
    }
    if isReloadInProgress || isLoadMoreInProgress {
      let props = MoviesCategoryVCProps(categoryId: categoryId,
                                        categoryName: categoryName,
                                        isReloadInProgress: isReloadInProgress,
                                        isLoadMoreInProgress: isLoadMoreInProgress,
                                        moviesUsage: .reload,
                                        movies: [])
      _updateProps(props)
    }
  }
}
