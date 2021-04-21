//
//  ConnectorFactory.swift
//  TopMovies
//
//  Created by anikolaenko on 18.03.2021.
//

import Overture

final class ConnectorFactory: ConnectorFactoryProtocol {
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
                                  -> (@escaping (@escaping (MainState) -> Void) -> ANStoreProvider)
                                  -> BaseConnector<Props, ANStoreProvider>)
  -> (@escaping (Props) -> Void) -> BaseConnector<Props, ANStoreProvider> {
    flip(base)(ANStoreProvider.init(stateUpdate:))
  }
}
