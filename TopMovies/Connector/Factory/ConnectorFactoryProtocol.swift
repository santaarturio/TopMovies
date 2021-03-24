//
//  ConnectorFactoryProtocol.swift
//  TopMovies
//
//  Created by Macbook Pro  on 20.03.2021.
//

typealias TopMoviesConnectorType
  = (@escaping (TopMoviesProps) -> Void) -> BaseConnector<TopMoviesProps, StoreProvider<MainState>>
typealias MoviesCategoryConnectorType
  = (@escaping (MoviesCategoryVCProps) -> Void) -> BaseConnector<MoviesCategoryVCProps, StoreProvider<MainState>>

protocol ConnectorFactoryProtocol {
  func createTopMoviesConnector()
  -> TopMoviesConnectorType
  func createCategoryVCConnector(_ categoryId: MovieCategory.ID)
  -> MoviesCategoryConnectorType
}
