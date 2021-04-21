//
//  ConnectorFactoryProtocol.swift
//  TopMovies
//
//  Created by Macbook Pro  on 20.03.2021.
//

typealias WelcomeConnectorType
  = (@escaping (WelcomeVCProps) -> Void) -> BaseConnector<WelcomeVCProps, ANStoreProvider>
typealias TopMoviesConnectorType
  = (@escaping (TopMoviesProps) -> Void) -> BaseConnector<TopMoviesProps, ANStoreProvider>
typealias MoviesCategoryConnectorType
  = (@escaping (MoviesCategoryVCProps) -> Void) -> BaseConnector<MoviesCategoryVCProps, ANStoreProvider>
typealias MovieConnectorType
  = (@escaping (MovieVCProps) -> Void) -> BaseConnector<MovieVCProps, ANStoreProvider>

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
