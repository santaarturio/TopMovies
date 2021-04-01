//
//  ANStoreSubscriber.swift
//  TopMovies
//
//  Created by Macbook Pro  on 14.04.2021.
//

import Foundation

protocol ANStoreSubscriber {
  associatedtype State
  
  func newState(state: State)
}
