//
//  MovieVCConnector.swift
//  TopMovies
//
//  Created by Macbook Pro  on 22.03.2021.
//

class MovieVCConnector<Provider: StoreProviderProtocol>: BaseConnector<MovieVCProps, Provider>
where Provider.ExpectedStateType == MainState {
  @Inject private var router: RouterProtocol
  private let movieId: MoviePreview.ID
  private var isMovieSent = false
  
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
    guard
      let updateState = state.moviesUpdateState.relational[movieId],
      updateState.isDownloading || state.moviesState.moviesRelational[movieId] != nil,
      !isMovieSent
    else { return }
    
    let props = MovieVCProps(downloadingInProgress: updateState.isDownloading,
                             movie: state.moviesState.moviesRelational[movieId],
                             preview: state.moviesState.previewsRelational[movieId],
                             actionBackButton: { [unowned self] _ in router.perform(route: .dismiss) })
    updateProps(props)
    isMovieSent = state.moviesState.moviesRelational[movieId] != nil
  }
}
