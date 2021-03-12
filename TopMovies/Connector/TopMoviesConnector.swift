//
//  TopMoviesConnector.swift
//  TopMovies
//
//  Created by anikolaenko on 10.02.2021.
//

import ReSwift

final class TopMoviesConnector: BaseConnector<TopMoviesProps> {
  private typealias CategoriesRelational = [MovieCategory.ID: [Movie.ID]]
  private let numberOfVisiableMoviesInCategory = 13
  private var alreadyShown: CategoriesRelational = [:]
  
  required init(updateProps: @escaping (TopMoviesProps) -> Void) {
    super.init(updateProps: updateProps)
    
    mainStore.dispatch(RequestMovieCategoriesAction())
  }
  
  override func newState(state: MainState) {
    guard
      case let .completed(categoriesID) = state.movieCategoriesState.categoriesList
    else { return }
    
    let updatedCategories = categoriesID
      .reduce(into: CategoriesRelational()) { dict, categoryID in
        var list = state.categoriesPaginationState.paginated[categoryID]?.list ?? []
        list.removeLast(list.count - numberOfVisiableMoviesInCategory)
        dict[categoryID] = list
      }
    if isNewCategoriesList(oldList: alreadyShown,
                           newList: updatedCategories) {
      let props =
        TopMoviesProps(
          movieCategories:
            categoriesID
            .compactMap { categoryId in MovieCategoryProps(
              categoryNameText:
                state.movieCategoriesState.relational[categoryId]?.title,
              movies:
                updatedCategories[categoryId]?
                .compactMap{ MovieCollectionProps(
                  movie: state.moviesState.relational[$0]
                ) } ?? [],
              actionAllButton: { Router.shared.perform(route: .categoryVC(categoryId: categoryId)) })
            }
        )
      _updateProps(props)
      alreadyShown = updatedCategories
    }
  }
  
  private func isNewCategoriesList(oldList old: CategoriesRelational,
                                   newList new: CategoriesRelational) -> Bool {
    new.first { key, value in old[key] == nil || old[key]?.elementsEqual(value) == false } != nil
  }
}
