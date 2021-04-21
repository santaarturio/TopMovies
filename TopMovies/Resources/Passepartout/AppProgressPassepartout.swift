//
//  AppProgressPassepartout.swift
//  TopMovies
//
//  Created by Macbook Pro  on 19.04.2021.
//

import Foundation

enum AppProgressPassepartout {
  static var choosenServiceKey: String { "choosen service" }
}

@propertyWrapper
struct AppProgressStorage<T> {
  private let container: UserDefaults = .standard
  private let key: String
  
  init(key: String) {
    self.key = key
  }
  
  var wrappedValue: T? {
    get { container.object(forKey: key) as? T }
    set {
      newValue != nil ?
        container.set(newValue, forKey: key) : container.removeObject(forKey: key)
    }
  }
}
