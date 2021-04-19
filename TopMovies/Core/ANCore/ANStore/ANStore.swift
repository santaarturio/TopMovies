//
//  ANStore.swift
//  TopMovies
//
//  Created by Macbook Pro  on 14.04.2021.
//

import RxSwift
import RxCocoa

final class ANStore<State: ANState> where State.Value == State {
  typealias Reducer = (ANAction, State) -> State
  
  private var state: State {
    didSet { stateSubject.onNext(state) }
  }
  private let reducer: Reducer
  
  var stateObservable: Observable<State> { Observable.just(state) }
  let stateSubject = BehaviorSubject<State>(value: State.defaultValue)
  
  init(_ state: State, _ reducer: @escaping Reducer) {
    self.state = state
    self.reducer = reducer
  }

  func dispatch(_ action: ANAction) {
    state = reducer(action, state)
  }
}
