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
    
    if !isExistingMoviesConnected {
      switch state.movieCategoriesState.categoriesList {
      case let .completed(categoriesID) where categoriesID.contains(categoryID):
        guard let props = MoviesCategoryVCProps(
          categoryName:
            state.movieCategoriesState.relational[categoryID]?.title,
          movies:
            state.movieCategoriesState.relational[categoryID]?.movies
            .compactMap{ MovieTableViewCellProps(movie: state.moviesState.relational[$0]) } ?? []
        ) else { return }
        _updateProps(props)
        isExistingMoviesConnected = !isExistingMoviesConnected
      default: break
      }
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
