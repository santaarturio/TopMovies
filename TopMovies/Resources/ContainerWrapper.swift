//
//  ContainerWrapper.swift
//  TopMovies
//
//  Created by Macbook Pro  on 19.03.2021.
//

import Swinject

public struct ContainerWrapper {
  public let registrar: Container
  public let resolver: Resolver
  
  public init(container: Container) {
    registrar = container
    resolver = container.synchronize()
  }
}

public extension Container {
  static var `default`: ContainerWrapper = {
    let container = Container()
    return ContainerWrapper(container: container)
  }()
}

@propertyWrapper
public final class Inject<Component> {
  private lazy var component: Component = resolver.resolve(Component.self)!
  private let resolver: Resolver
  
  public init(_ resolver: Resolver = Container.default.resolver) {
    self.resolver = resolver
  }
  
  public var wrappedValue: Component { component }
}
