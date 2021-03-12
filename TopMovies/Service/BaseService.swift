//
//  BaseService.swift
//  TopMovies
//
//  Created by anikolaenko on 15.03.2021.
//

class BaseService<Provider: StoreProviderProtocol>  {
  private(set) var provider: Provider!
  
  typealias StateType = Provider.ExpectedStateType
  typealias StateUpdate = (StateType) -> Void
  
  init(provider: (@escaping StateUpdate) -> Provider) {
    self.provider = provider { [weak self] state in self?.newState(state: state) }
  }
  
  func newState(state: StateType) {
    fatalError("func newState(state:) should be overriden")
  }
}
