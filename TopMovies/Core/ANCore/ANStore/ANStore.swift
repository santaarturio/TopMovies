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
  
  private let reducer: Reducer
  private let stateSubject = BehaviorRelay(value: State.defaultValue)
  
  var currentState: State { stateSubject.value }
  var observableState: Observable<State> {
    stateSubject.asObservable()
    .observe(on: MainScheduler.asyncInstance)
  }
  
  init(_ reducer: @escaping Reducer) {
    self.reducer = reducer
  }

  func dispatch(_ action: ANAction) {
    stateSubject.accept(reducer(action, currentState))
  }
}
