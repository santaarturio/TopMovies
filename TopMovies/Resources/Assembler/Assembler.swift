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

struct Assembler {
  static func registerDependencies() {
    let registrar = Container.default.registrar
    
    // MARK: - Store
    registrar.register(MainStore.self) { _ in
      MainStore(reducer: mainReducer, state: nil, middleware: [allActionsMiddleware])
    }.inObjectScope(.container)
    
    // MARK: - Service
    registrar.autoregister(MovieAPIProtocol.self, initializer: MovieAPI.init)
    registrar.register(MovieService<StoreProvider<MainState>>.self) { resolver in
      MovieService(
        movieAPI: resolver ~> MovieAPIProtocol.self,
        storeProvider: curry(StoreProvider<MainState>.init(store: onStateUpdate:))(resolver.resolve(MainStore.self)!)
      )
    }.inObjectScope(.container)
    
    // MARK: - Factory
    registrar.autoregister(VCFactoryProtocol.self, initializer: VCFactory.init)
    registrar.autoregister(ConnectorFactoryProtocol.self, initializer: ConnectorFactory.init)
    
    // MARK: - Router
    registrar.autoregister(RouterProtocol.self, initializer: Router.init)
      .inObjectScope(.container)
  }
}
