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
    
    self.provider.dispatch(RequestMovieUpdateAction.init(movieId: movieId))
  }
  
  override func newState(state: MainState) {
    guard let updateState = state.moviesUpdateState.relational[movieId] else { return }
    var props: MovieVCProps!
    switch updateState {
    case .downloading:
      props = .init(downloadingInProgress: true)
      _updateProps(props)
    case .updated:
      state.moviesState.moviesRelational[movieId]
        .flatMap { props = .init(movie: $0); _updateProps(props) }
    default: break
    }
  }
}
