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
  
  static func prettyDate(from string: String) -> Date {
    guard
      let date = DateFormatter.cached(withFormat: "yyyy-mm-dd")
        .date(from: string)
    else { return Date() }
    return date
  }
  static func prettyDateString(from date: Date) -> String {
    DateFormatter.cached(withFormat: "MMM, dd - yyyy")
      .string(from: date)
  }
  
  static func isNew(date: Date) -> Bool {
    return abs(
      date.months(from: Date())) < 3
  }
}
