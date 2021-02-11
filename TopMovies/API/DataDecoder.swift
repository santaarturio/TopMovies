//
//  DataDecoder.swift
//  TopMovies
//
//  Created by anikolaenko on 05.02.2021.
//

import Foundation

struct DataDecoder {
  static func decode<T: Decodable>(_ decodableType: T.Type, fromJSON data: Data) -> T? {
    try? JSONDecoder().decode(decodableType, from: data)
  }
}
