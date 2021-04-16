//
//  Assembler.swift
//  TopMovies
//
//  Created by Macbook Pro  on 19.03.2021.
//

import Swinject
import SwinjectAutoregistration
import ReSwift
import Overture

typealias MainStore = Store<MainState>

final class Assembler: StoreSubscriber {
  @Inject private var store: MainStore
  @Inject private var passepartout: ServicesPassepartoutProtocol
  private var registeredAPI: MoviesServiceState = .initial
  private let registrar = Container.default.registrar
  
  static let `default` = Assembler()
  
  func registerDependencies() {
    // MARK: - Store
    registrar.register(MainStore.self) { _ in
      MainStore(reducer: mainReducer, state: nil, middleware: [allActionsMiddleware])
    }.inObjectScope(.container)
    
    // MARK: - Factory
    registrar.autoregister(VCFactoryProtocol.self, initializer: VCFactory.init)
    registrar.autoregister(ConnectorFactoryProtocol.self, initializer: ConnectorFactory.init)
    
    // MARK: - Router
    registrar.autoregister(RouterProtocol.self, initializer: Router.init)
      .inObjectScope(.container)
    
    // MARK: - Passepartout
    registrar.autoregister(ServicesPassepartoutProtocol.self, initializer: ServicesPassepartout.init)
    
    store.subscribe(self)
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
    
    registrar.register(MovieService<StoreProvider<MainState>>.self) { resolver in
      MovieService(
        movieAPI: resolver ~> MovieAPIProtocol.self,
        storeProvider: curry(StoreProvider<MainState>.init(store: onStateUpdate:))(resolver.resolve(MainStore.self)!)
      )
    }.inObjectScope(.container)
    
    _ = Container.default.resolver.resolve(MovieService<StoreProvider<MainState>>.self)
    
    StreamingService
      .init(state: state.moviesServiceState)
      .map(passepartout.configureApiKey(for:))
  }
}
