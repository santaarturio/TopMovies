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
  static func prettyDate(_ dateString: String) -> String {
    guard
      let date = DateFormatter.cached(withFormat: "yyyy-mm-dd")
        .date(from: dateString)
    else { return "no date" }
    return DateFormatter.cached(withFormat: "MMM, dd - yyyy")
      .string(from: date)
  }
  static func isNew(dateString: String) -> Bool {
    return abs(
      (DateFormatter
        .cached(withFormat: "yyyy-mm-dd")
        .date(from: dateString) ?? Date())
        .months(from: Date())) < 3
  }
}
