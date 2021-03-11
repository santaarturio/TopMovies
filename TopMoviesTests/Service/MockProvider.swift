//
//  MockProvider.swift
//  TopMoviesTests
//
//  Created by anikolaenko on 11.03.2021.
//

@testable import TopMovies
import ReSwift

final class MockStoreProvider<ExpectedStateType>: StoreProviderProtocol {
  var dispatchedActions: [Action] = []
  var onStateUpdate: (ExpectedStateType) -> Void

  init(onStateUpdate: @escaping (ExpectedStateType) -> Void) {
    self.onStateUpdate = onStateUpdate
  }

  func dispatch(_ action: Action) {
    dispatchedActions.append(action)
  }
}
