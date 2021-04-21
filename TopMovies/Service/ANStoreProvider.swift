//
//  ANStoreProvider.swift
//  TopMovies
//
//  Created by Macbook Pro  on 19.04.2021.
//

import RxSwift
import RxCocoa

final class ANStoreProvider: StoreProviderProtocol {
  private(set) var onStateUpdate: (MainState) -> Void
  @Inject private var store: AppStore
  
  private let disposeBag = DisposeBag()
  
  init(stateUpdate: @escaping (MainState) -> Void) {
    onStateUpdate = stateUpdate
    
    store.observableState.subscribe { state in
      stateUpdate(state)
    }.disposed(by: disposeBag)
  }
  
  func dispatch(_ action: ANAction) {
    store.dispatch(action)
  }
}
