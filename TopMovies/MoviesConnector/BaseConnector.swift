//
//  BaseConnector.swift
//  TopMovies
//
//  Created by anikolaenko on 10.02.2021.
//

import ReSwift

class BaseConnector<PropsType>: StoreSubscriber {
  typealias Props = PropsType
  typealias StoreSubscriberStateType = MainState
  
  let _updateProps: (Props) -> Void
  
  required init(updateProps: @escaping (Props) -> Void) {
    _updateProps = updateProps
    mainStore.subscribe(self)
  }
  deinit {
    mainStore.unsubscribe(self)
  }
  
  func newState(state: MainState) {
    fatalError("newState func should be overriden")
  }
}
