//
//  ConnectorFactory.swift
//  TopMovies
//
//  Created by anikolaenko on 18.03.2021.
//

import Overture

final class ConnectorFactory: ConnectorFactoryProtocol {
  @Inject private var mainStore: MainStore
  
  func createWelcomeConnector() -> WelcomeConnectorType {
    connector(curry(WelcomeVCConnector.init(updateProps: provider:)))
  }
  func createTopMoviesConnector() -> TopMoviesConnectorType {
    connector(curry(TopMoviesConnector.init(updateProps: provider:)))
  }
  func createCategoryVCConnector(_ categoryId: MovieCategory.ID) -> MoviesCategoryConnectorType {
    connector(curry(CategoryVCConnector.init(categoryId: updateProps: provider:))(categoryId))
  }
  func createMovieVCConnector(_ movieId: MoviePreview.ID) -> MovieConnectorType {
    connector(curry(MovieVCConnector.init(movieId: updateProps: provider:))(movieId))
  }
  
  private func connector<Props>(_ base: @escaping (@escaping (Props) -> Void)
                                  -> (@escaping (@escaping (MainState) -> Void) -> StoreProvider<MainState>)
                                  -> BaseConnector<Props, StoreProvider<MainState>>)
  -> (@escaping (Props) -> Void) -> BaseConnector<Props, StoreProvider<MainState>> {
    flip(base)(curry(StoreProvider<MainState>
                      .init(store: onStateUpdate:))(mainStore))
  }
}
