//
//  DefaultableProtocol.swift
//  TopMovies
//
//  Created by Macbook Pro  on 23.02.2021.
//

protocol Defaultable {
  associatedtype Value
  static var defaultValue: Value { get }
}
