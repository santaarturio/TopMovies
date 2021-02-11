//
//  TopMoviesConnector.swift
//  TopMovies
//
//  Created by anikolaenko on 10.02.2021.
//

import ReSwift

class TopMoviesConnector: BaseConnector<TopMoviesProps> {
  
  required init(updateProps: @escaping (TopMoviesProps) -> Void) {
    super.init(updateProps: updateProps)
  }
  
  override func newState(state: MainState) {
    switch state.movieCategoriesState.categoriesList {
    case let .completed(categoriesID):
      let props =
        TopMoviesProps(movieCategories: categoriesID
                        .map{ MovieCategoryProps(categoryNameText: state.movieCategoriesState.relational[$0]!.title,
                                                 movies: state.movieCategoriesState.relational[$0]!.movies
                                                  .map{ MovieCollectionProps(movie: $0) }) })
      _updateProps(props)
    default: break
    }
  }
}