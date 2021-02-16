//
//  Dictionary+.swift
//  TopMovies
//
//  Created by anikolaenko on 13.02.2021.
//

import Foundation

extension Dictionary {
  mutating func merge(dict: [Key: Value]) -> Self {
    for (key, value) in dict {
      updateValue(value, forKey: key)
    }
    return self
  }
}
