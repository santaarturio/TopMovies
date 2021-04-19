//
//  AppState.swift
//  TopMovies
//
//  Created by Macbook Pro  on 14.04.2021.
//

import Foundation

struct AppState { }

extension AppState: ANState {
  static var defaultValue: AppState =
    .init()
}
