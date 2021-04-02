//
//  DispatchQueue+Extensions.swift
//  TopMovies
//
//  Created by anikolaenko on 31.03.2021.
//

import Foundation

extension DispatchQueue {
  static let defaultSerialQueue = DispatchQueue(label: "com.topMovies.defaultSerialQueue",
                                                qos: .utility)
}
