//
//  UpdateConfigurationAction.swift
//  TopMovies
//
//  Created by anikolaenko on 04.02.2021.
//

import ReSwift

enum UpdateConfigurationAction: Action, ANAction {
  case configureAPIKey(_: String)
}
