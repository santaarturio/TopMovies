//
//  Assembler.swift
//  TopMovies
//
//  Created by Macbook Pro  on 19.03.2021.
//

import Swinject
import SwinjectAutoregistration
import RxSwift
import Overture

typealias AppStore = ANStore<MainState>

final class Assembler {
  @Inject private var store: AppStore
  @Inject private var passepartout: ServicesPassepartoutProtocol
  private var registeredAPI: MoviesServiceState = .initial
  private let registrar = Container.default.registrar
  private let disposeBag = DisposeBag()
  
  static let `default` = Assembler()
  
  func registerDependencies() {
    // MARK: - Store
    registrar.register(AppStore.self) { _ in AppStore(anReducer) }
      .inObjectScope(.container)
    
    // MARK: - Factory
    registrar.autoregister(VCFactoryProtocol.self, initializer: VCFactory.init)
    registrar.autoregister(ConnectorFactoryProtocol.self, initializer: ConnectorFactory.init)
    
    // MARK: - Router
    registrar.autoregister(RouterProtocol.self, initializer: Router.init)
      .inObjectScope(.container)
    
    // MARK: - Passepartout
    registrar.autoregister(ServicesPassepartoutProtocol.self, initializer: ServicesPassepartout.init)
    
    store.observableState.subscribe(onNext: { [weak self] state in
      self?.newState(state: state)
    }).disposed(by: disposeBag)
  }
  
  func newState(state: MainState) {
    if state.moviesServiceState == registeredAPI { return }
    
    switch state.moviesServiceState {
    case .tmdb:
      registrar.autoregister(MovieAPIProtocol.self, initializer: MovieAPI.init)
    case .quintero:
      registrar.autoregister(MovieAPIProtocol.self, initializer: MovieAPIGraphQL.init)
    case .initial: fallthrough
    @unknown default: return
    }
    
    registeredAPI = state.moviesServiceState
    
    registrar.register(MovieService<ANStoreProvider>.self) { resolver in
      MovieService(
        movieAPI: resolver ~> MovieAPIProtocol.self,
        storeProvider: ANStoreProvider.init(stateUpdate:)
      )
    }.inObjectScope(.container)
    
    _ = Container.default.resolver.resolve(MovieService<ANStoreProvider>.self)
    
    StreamingService
      .init(state: state.moviesServiceState)
      .map(passepartout.configureApiKey(for:))
  }
}
