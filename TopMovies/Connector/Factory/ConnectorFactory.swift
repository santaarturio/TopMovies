//
//  ConnectorFactory.swift
//  TopMovies
//
//  Created by anikolaenko on 18.03.2021.
//

import Overture

final class ConnectorFactory: ConnectorFactoryProtocol {
  @Inject private var mainStore: MainStore
  func createTopMoviesConnector() -> TopMoviesConnectorType {
    flip(
      curry(
        TopMoviesConnector
          .init(updateProps: provider: ))
    )(curry(
        StoreProvider<MainState>
          .init(store: onStateUpdate: ))(mainStore))
  }
  func createCategoryVCConnector(_ categoryId: MovieCategory.ID) -> MoviesCategoryConnectorType {
    flip(
      curry(
        CategoryVCConnector
          .init(categoryId: updateProps: provider: ))(categoryId)
    )(curry(
        StoreProvider<MainState>
          .init(store: onStateUpdate: ))(mainStore))
  }
}
