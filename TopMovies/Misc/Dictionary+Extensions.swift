//
//  Dictionary+Extensions.swift
//  TopMovies
//
//  Created by Macbook Pro  on 20.02.2021.
//

public extension Array {
  func hashMap<T>(into: [T: Element] = [:], id keyPath: KeyPath<Element, T>) -> [T: Element] {
    reduce(into, TopMovies.hashMap(byKeyPath: keyPath))
  }
}
public func hashMap<T, U>(byKeyPath keyPath: KeyPath<T, U>) -> ([U: T], T) -> [U: T] {
  { whole, element in
    var copy = whole
    copy[element[keyPath: keyPath]] = element
    return copy
  }
}
