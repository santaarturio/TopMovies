//
//  ANMainStore.swift
//  TopMovies
//
//  Created by Macbook Pro  on 14.04.2021.
//

import RxSwift

final class ANStore<State: ANStateProtocol>: ANStoreProtocol
where State.Value == State {
  typealias Reducer = (State, ANAction) -> State
  
  private(set) var state: State {
    didSet { subject.onNext(state) }
  }
  private(set) var reducer: Reducer
  
  private let subject = BehaviorSubject<State>(value: State.defaultValue)
  
  init(_ state: State, _ reducer: @escaping Reducer) {
    self.state = state
    self.reducer = reducer
  }
  
  func subscribe<T: ANStoreSubscriber>(_ subscriber: T)
  where T.State == State {
    _ = subject.subscribe { _ = $0.map(subscriber.newState(state:)) }
  }
  func unsubscribe<T: ANStoreSubscriber>(_ subscriber: T)
  where T.State == State {
    
  }
  func dispatch(_ action: ANAction) {
    state = reducer(state, action)
  }
}
