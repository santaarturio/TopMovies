//
//  Date+Extensions.swift
//  TopMovies
//
//  Created by Macbook Pro  on 25.02.2021.
//

import Foundation

extension Date {
  func months(from date: Date) -> Int {
    return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
  }
}
