//
//  ANStoreProtocol.swift
//  TopMovies
//
//  Created by Macbook Pro  on 14.04.2021.
//

import Foundation

protocol ANStoreProtocol {
  associatedtype State: ANStateProtocol
  typealias Reducer = (State, ANAction) -> State
  
  var state: State { get }
  var reducer: Reducer { get }
  
  init(_ state: State, _ reducer: @escaping Reducer)
  
  func subscribe<T: ANStoreSubscriber>(_ subscriber: T) where T.State == State
  func unsubscribe<T: ANStoreSubscriber>(_ subscriber: T) where T.State == State
  func dispatch(_ action: ANAction)
}
