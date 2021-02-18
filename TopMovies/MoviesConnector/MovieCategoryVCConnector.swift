//
//  MovieCategoryVCConnector.swift
//  TopMovies
//
//  Created by Macbook Pro  on 17.02.2021.
//

import Foundation

class MovieCategoryVCConnector: BaseConnector<MoviesCategoryVCProps> {
  var categoryID: MovieCategory.ID?
  var isExistingMoviesConnected = false
  
  required init(updateProps: @escaping (MoviesCategoryVCProps) -> Void) {
    super.init(updateProps: updateProps)
  }
  convenience init(categoryID: MovieCategory.ID, updateProps: @escaping (MoviesCategoryVCProps) -> Void) {
    self.init(updateProps: updateProps)
    self.categoryID = categoryID
    mainStore.dispatch(MoviesDownloadingAction.requestFor(category: categoryID))
  }
  
  override func newState(state: MainState) {
    guard let categoryID = categoryID else { return }
    
    if !isExistingMoviesConnected,
       let existingMovies = state.categoryRequestsState.alreadyDownloaded[categoryID],
       let props = MoviesCategoryVCProps(
        categoryName:
          state.movieCategoriesState.relational[categoryID]?.title,
        movies:
          existingMovies
          .compactMap{ MovieTableViewCellProps(movie: state.moviesState.relational[$0]) })
    {
      _updateProps(props)
      isExistingMoviesConnected = !isExistingMoviesConnected
    }
    
    switch state.categoryRequestsState.categoryRequests[categoryID] {
    case let .completed(data: moviesID):
      let props =
        MoviesCategoryVCProps(categoryName: categoryID.value,
                              movies: moviesID
                                .compactMap {
                                  MovieTableViewCellProps(movie: state.moviesState.relational[$0])
                                })
      _updateProps(props)
    default: break
    }
  }
}
