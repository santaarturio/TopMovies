//
//  MovieVCConnector.swift
//  TopMovies
//
//  Created by Macbook Pro  on 22.03.2021.
//

class MovieVCConnector<Provider: StoreProviderProtocol>: BaseConnector<MovieVCProps, Provider>
where Provider.ExpectedStateType == MainState {
  private let movieId: MoviePreview.ID
  
  typealias StateUpdate = (Provider.ExpectedStateType) -> Void
  init(movieId: MoviePreview.ID,
       updateProps: @escaping (MovieVCProps) -> Void,
       provider: (@escaping StateUpdate) -> Provider) {
    
    self.movieId = movieId
    super.init(updateProps: updateProps,
               provider: provider)
  }
  
  override func newState(state: MainState) { }
}
