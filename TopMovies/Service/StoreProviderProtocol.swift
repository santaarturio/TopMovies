//
//  StoreProviderProtocol.swift
//  TopMovies
//
//  Created by anikolaenko on 11.03.2021.
//

import ReSwift

protocol StoreProviderProtocol {
  associatedtype ExpectedStateType

  var onStateUpdate: (ExpectedStateType) -> Void { get }
  func dispatch(_: Action)
}
