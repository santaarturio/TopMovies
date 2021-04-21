//
//  ConfigurationState.swift
//  TopMovies
//
//  Created by anikolaenko on 04.02.2021.
//

import ReSwift

enum ConfigurationState: StateType, Equatable, AutoEnum {
  case initial
  case configuredAPIKey(String)
}

extension ConfigurationState: ANState {
  static var defaultValue: ConfigurationState = .initial
}

extension ConfigurationState {
  static func reduce(action: ANAction, state: ConfigurationState) -> ConfigurationState {
    switch action {
    case let UpdateConfigurationAction.configureAPIKey(key):
      return configuredAPIKey(key)
    default: return state
    }
  }
}
