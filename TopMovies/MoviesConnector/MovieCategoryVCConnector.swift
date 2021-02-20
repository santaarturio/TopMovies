//
//  MovieCategoryVCConnector.swift
//  TopMovies
//
//  Created by Macbook Pro  on 17.02.2021.
//

import Foundation

class MovieCategoryVCConnector: BaseConnector<MoviesCategoryVCProps> {
  var categoryID: MovieCategory.ID?
  var downloadedMovies: [Movie.ID] = []
  var isExistingMoviesConnected = false
  
  required init(updateProps: @escaping (MoviesCategoryVCProps) -> Void) {
    super.init(updateProps: updateProps)
  }
  convenience init(categoryID: MovieCategory.ID, updateProps: @escaping (MoviesCategoryVCProps) -> Void) {
    self.init(updateProps: updateProps)
    self.categoryID = categoryID
    mainStore.dispatch(MoviesRequestAction(categoryId: categoryID, requestType: .loadMore))  }
  
  override func newState(state: MainState) {
    guard let categoryID = categoryID else { return }
    
    if !isExistingMoviesConnected,
       let existingMovies = state.paginationState.paginated[categoryID]?.list,
       let props = MoviesCategoryVCProps(
        categoryName:
          state.movieCategoriesState.relational[categoryID]?.title,
        movies:
          existingMovies
          .compactMap{ MovieTableViewCellProps(movie: state.moviesState.relational[$0]) })
    {
      _updateProps(props)
      isExistingMoviesConnected = !isExistingMoviesConnected
      downloadedMovies = existingMovies
    }
    
    guard
      let moviesList = state.paginationState.paginated[categoryID]?.list,
      moviesList.count > downloadedMovies.count
    else { return }
    
    var moviesListDiff = moviesList
    moviesListDiff.removeSubrange(0..<downloadedMovies.count)
    downloadedMovies.append(contentsOf: moviesListDiff)
    if let props =
        MoviesCategoryVCProps(categoryName: state.movieCategoriesState.relational[categoryID]?.title,
                              movies: moviesListDiff
                                .compactMap {
                                  MovieTableViewCellProps(movie: state.moviesState.relational[$0])
                                })
    { _updateProps(props) }
  }
}
