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
<<<<<<< ours
      let props = TopMoviesProps(
        movieCategories: categoriesID
          .compactMap{
            MovieCategoryProps(
=======
      let props =
        TopMoviesProps(
          movieCategories:
            categoriesID
            .compactMap{ MovieCategoryProps(
>>>>>>> theirs
              categoryNameText:
                state.movieCategoriesState.relational[$0]?.title,
              movies:
                state.movieCategoriesState.relational[$0]?.movies
<<<<<<< ours
                .compactMap{
                  MovieCollectionProps(movie: state.moviesState.relational[$0])
                })})
=======
                .compactMap{ MovieCollectionProps(
                  movie: state.moviesState.relational[$0]
                ) } ?? [] )
            }
        )
>>>>>>> theirs
      _updateProps(props)
    default: break
    }
  }
}
