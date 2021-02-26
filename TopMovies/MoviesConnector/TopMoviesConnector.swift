//
//  TopMoviesConnector.swift
//  TopMovies
//
//  Created by anikolaenko on 10.02.2021.
//

import ReSwift

class TopMoviesConnector: BaseConnector<TopMoviesProps> {
  private let numberOfVisiableMoviesInCategory = 13
  private var alreadyShown: [MovieCategory.ID: [Movie.ID]] = [:]
  
  required init(updateProps: @escaping (TopMoviesProps) -> Void) {
    super.init(updateProps: updateProps)
  }
  
  override func newState(state: MainState) {
    switch state.movieCategoriesState.categoriesList {
    case let .completed(categoriesID):
      let updatedCategories = categoriesID
        .reduce(into: [MovieCategory.ID: [Movie.ID]]()) { dict, categoryID in
          var list = state.categoriesPaginationState.paginated[categoryID]?.list ?? []
          list.removeLast(list.count - numberOfVisiableMoviesInCategory)
          dict[categoryID] = list
        }
      if updatedCategories != alreadyShown {
        let props =
          TopMoviesProps(
            movieCategories:
              categoriesID
              .compactMap{ MovieCategoryProps(
                categoryId: $0,
                categoryNameText:
                  state.movieCategoriesState.relational[$0]?.title,
                movies:
                  updatedCategories[$0]?
                  .compactMap{ MovieCollectionProps(
                    movie: state.moviesState.relational[$0]
                  ) } ?? [] )
              }
          )
        _updateProps(props)
        alreadyShown = updatedCategories
      }
    default: break
    }
  }
}
