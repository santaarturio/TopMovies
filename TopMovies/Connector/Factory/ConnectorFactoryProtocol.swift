//
//  ConnectorFactoryProtocol.swift
//  TopMovies
//
//  Created by Macbook Pro  on 20.03.2021.
//

typealias WelcomeConnectorType
  = (@escaping (WelcomeVCProps) -> Void) -> BaseConnector<WelcomeVCProps, StoreProvider<MainState>>
typealias TopMoviesConnectorType
  = (@escaping (TopMoviesProps) -> Void) -> BaseConnector<TopMoviesProps, StoreProvider<MainState>>
typealias MoviesCategoryConnectorType
  = (@escaping (MoviesCategoryVCProps) -> Void) -> BaseConnector<MoviesCategoryVCProps, StoreProvider<MainState>>
typealias MovieConnectorType
  = (@escaping (MovieVCProps) -> Void) -> BaseConnector<MovieVCProps, StoreProvider<MainState>>

protocol ConnectorFactoryProtocol {
  func createWelcomeConnector()
  -> WelcomeConnectorType
  func createTopMoviesConnector()
  -> TopMoviesConnectorType
  func createCategoryVCConnector(_ categoryId: MovieCategory.ID)
  -> MoviesCategoryConnectorType
  func createMovieVCConnector(_ movieId: MoviePreview.ID)
  -> MovieConnectorType
}
