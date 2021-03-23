//
//  CategoryVCConnector.swift
//  TopMovies
//
//  Created by Macbook Pro  on 17.02.2021.
//

final class CategoryVCConnector<Provider: StoreProviderProtocol>: BaseConnector<MoviesCategoryVCProps, Provider>
where Provider.ExpectedStateType == MainState {
  private let categoryId: MovieCategory.ID
  
  typealias StateUpdate = (Provider.ExpectedStateType) -> Void
  init(categoryId: MovieCategory.ID,
       updateProps: @escaping (MoviesCategoryVCProps) -> Void,
       provider: (@escaping StateUpdate) -> Provider) {
    
    self.categoryId = categoryId
    super.init(updateProps: updateProps,
               provider: provider)
    self.provider.dispatch(RequestedPreviewsListAction(categoryId: categoryId,
                                                       requestType: .loadMore))
  }
  
  override func newState(state: MainState) {
    guard
      let categoryName = state.movieCategoriesState.relational[categoryId]?.title,
      let categoryState = state.categoriesPaginationState.paginated[categoryId]
    else { return }
    
    let props = MoviesCategoryVCProps(categoryName: categoryName,
                                      isReloadInProgress: categoryState.reload.isDownloading,
                                      isLoadMoreInProgress: categoryState.loadMore.isDownloading,
                                      movies: categoryState.list
                                        .compactMap {
                                          MovieTableViewCellProps(movie: state.moviesState.previewsRelational[$0])
                                        },
                                      actionReload: { [unowned self] in provider
                                        .dispatch(RequestedPreviewsListAction(categoryId: categoryId,
                                                                              requestType: .reload)) },
                                      actionLoadMore: { [unowned self] in provider
                                        .dispatch(RequestedPreviewsListAction(categoryId: categoryId,
                                                                              requestType: .loadMore)) })
    _updateProps(props)
  }
}
