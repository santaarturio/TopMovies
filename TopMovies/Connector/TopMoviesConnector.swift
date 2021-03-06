//
//  TopMoviesConnector.swift
//  TopMovies
//
//  Created by anikolaenko on 10.02.2021.
//

import Foundation

final class TopMoviesConnector<Provider: StoreProviderProtocol>: BaseConnector<TopMoviesProps, Provider>
where Provider.ExpectedStateType == MainState {
  @Inject var router: RouterProtocol
  private typealias CategoriesRelational = [MovieCategory.ID: [MoviePreview.ID]]
  private let numberOfVisiableMoviesInCategory = 13
  private var alreadyShown: CategoriesRelational = [:]
  @AppProgressStorage(key: AppProgressPassepartout.choosenServiceKey)
  private var choosenService: String?
  
  typealias StateUpdate = (Provider.ExpectedStateType) -> Void
  override init(updateProps: @escaping (TopMoviesProps) -> Void,
                provider: (@escaping StateUpdate) -> Provider) {
    
    super.init(updateProps: updateProps,
               provider: provider)
    self.provider.dispatch(RequestMovieCategoriesAction())
  }
  
  override func newState(state: MainState) {
    guard
      case let .completed(categoriesID) = state.movieCategoriesState.categoriesList
    else { return }
    
    let updatedCategories = categoriesID
      .reduce(into: CategoriesRelational()) { dict, categoryID in
        var list = state.categoriesPaginationState.paginated[categoryID]?.list ?? []
        if list.count > numberOfVisiableMoviesInCategory {
          list.removeLast(list.count - numberOfVisiableMoviesInCategory)
        }
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
                .compactMap { movieId in MovieCollectionProps(
                  movie: state.moviesState.previewsRelational[movieId],
                  actionMovieDetail: { [unowned self] in router.perform(route: .movie(movieId)) }
                ) } ?? [],
              actionAllButton: { [unowned self] in router.perform(route: .category(categoryId)) })
            },
          rechooseServiceAction: { [unowned self] in
            router.perform(route: .welcome)
            choosenService = nil
          }
        )
      updateProps(props)
      alreadyShown = updatedCategories
    }
  }
  
  private func isNewCategoriesList(oldList old: CategoriesRelational,
                                   newList new: CategoriesRelational) -> Bool {
    new.first { key, value in old[key] == nil || old[key]?.elementsEqual(value) == false } != nil
  }
}
