//
//  StoreProvider.swift
//  TopMovies
//
//  Created by anikolaenko on 11.03.2021.
//

import ReSwift

final class StoreProvider<ExpectedStateType>: StoreProviderProtocol, StoreSubscriber where ExpectedStateType: StateType {
  private let store: Store<ExpectedStateType>
  
  var onStateUpdate: (ExpectedStateType) -> Void
  
  init(store: Store<ExpectedStateType>, onStateUpdate: @escaping (ExpectedStateType) -> Void) {
    self.store = store
    self.onStateUpdate = onStateUpdate
    store.subscribe(self)
  }
  deinit {
    store.unsubscribe(self)
  }
  
  func dispatch(_ action: Action) {
    store.dispatch(action)
  }
  func newState(state: ExpectedStateType) {
    onStateUpdate(state)
  }
}
