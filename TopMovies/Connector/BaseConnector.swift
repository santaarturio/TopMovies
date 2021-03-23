//
//  BaseConnector.swift
//  TopMovies
//
//  Created by anikolaenko on 10.02.2021.
//

class BaseConnector<PropsType, Provider: StoreProviderProtocol> {
  typealias Props = PropsType
  
  private(set) var provider: Provider!
  let _updateProps: (Props) -> Void
  
  typealias StateType = Provider.ExpectedStateType
  typealias StateUpdate = (StateType) -> Void
  
  init(updateProps: @escaping (Props) -> Void,
       provider: (@escaping StateUpdate) -> Provider) {
    _updateProps = updateProps
    self.provider = provider { [weak self] state in self?.newState(state: state) }
  }
  
  func newState(state: StateType) {
    fatalError("newState func should be overriden")
  }
}
