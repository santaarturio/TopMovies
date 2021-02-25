//
//  Date+Extensions.swift
//  TopMovies
//
//  Created by Macbook Pro  on 25.02.2021.
//

import Foundation

extension Date {
  static func prettyDate(_ date: String) -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-mm-dd"
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "MMM, dd - yyyy"
    return dateFormatterPrint.string(from: dateFormatterGet.date(from: date)  ?? Date())
  }
}
