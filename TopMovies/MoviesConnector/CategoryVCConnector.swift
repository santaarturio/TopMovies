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
      let props = MoviesCategoryVCProps(
        categoryId: categoryId,
        categoryName: categoryName,
        loadProgress: .init(isReloadInProgress: false,
                            isLoadMoreInProgress: false),
        moviesState: .init(hasNewData: true,
                           moviesUsage: .reload,
                           movies: moviesList
                            .compactMap { MovieTableViewCellProps(movie:
                                                                    state.moviesState.relational[$0]) }))
      _updateProps(props)
      isExistingMoviesConnected = !isExistingMoviesConnected
      downloadedMovies = moviesList
    }
    let categoryState = state.categoriesPaginationState.paginated[categoryId]
    if isDownloadingInProgress(categoryState)
    {
      var isReloadInProgress = false
      var isLoadMoreInProgress = false
      if case .downloading = categoryState?.reload {
        isReloadInProgress = true
      }
      if case .downloading = categoryState?.loadMore {
        isLoadMoreInProgress = true
      }
      let props = MoviesCategoryVCProps(
        categoryId: categoryId,
        categoryName: categoryName,
        loadProgress: .init(isReloadInProgress: isReloadInProgress,
                            isLoadMoreInProgress: isLoadMoreInProgress),
        moviesState: .init(hasNewData: false,
                           moviesUsage: .reload,
                           movies: []))
      _updateProps(props)
    } else {
      switch moviesList.count {
      case (downloadedMovies.count + 1)...:
        var listDiff = moviesList
        listDiff.removeSubrange(0..<downloadedMovies.count)
        let props = MoviesCategoryVCProps(
          categoryId: categoryId,
          categoryName: categoryName,
          loadProgress: .init(isReloadInProgress: false,
                              isLoadMoreInProgress: false),
          moviesState: .init(hasNewData: true,
                             moviesUsage: .loadMore,
                             movies: listDiff
                              .compactMap {
                                MovieTableViewCellProps(movie: state.moviesState.relational[$0])
                              }))
        _updateProps(props)
        downloadedMovies += listDiff
      case ...(downloadedMovies.count) where moviesList != downloadedMovies:
        let props = MoviesCategoryVCProps(
          categoryId: categoryId,
          categoryName: categoryName,
          loadProgress: .init(isReloadInProgress: false,
                              isLoadMoreInProgress: false),
          moviesState: .init(hasNewData: true,
                             moviesUsage: .reload,
                             movies: moviesList
                              .compactMap {
                                MovieTableViewCellProps(movie: state.moviesState.relational[$0])
                              }))
        downloadedMovies = moviesList
        _updateProps(props)
      case downloadedMovies.count:
        let props = MoviesCategoryVCProps(
          categoryId: categoryId,
          categoryName: categoryName,
          loadProgress: .init(isReloadInProgress: false,
                              isLoadMoreInProgress: false),
          moviesState: .init(hasNewData: false,
                             moviesUsage: .reload,
                             movies: []))
          _updateProps(props)
      default: break
      }
    }
  }
  
  func isDownloadingInProgress(_ categoryState: CategoriesPaginationState.CategoryState?) -> Bool {
    if case .downloading = categoryState?.reload {
      return true
    }
    if case .downloading = categoryState?.loadMore {
      return true
    }
    return false
  }
}
