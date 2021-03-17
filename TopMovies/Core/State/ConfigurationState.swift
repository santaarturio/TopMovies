//
//  ConfigurationState.swift
//  TopMovies
//
//  Created by anikolaenko on 04.02.2021.
//

import ReSwift

enum ConfigurationState: StateType, Equatable {
  case initial
  case configuredAPIKey(String)
}

extension ConfigurationState {
  static func reduce(action: Action, state: ConfigurationState) -> ConfigurationState {
    switch action {
    case let UpdateConfigurationAction.configureAPIKey(key):
      return configuredAPIKey(key)
    default: return state
    }
  }
}
