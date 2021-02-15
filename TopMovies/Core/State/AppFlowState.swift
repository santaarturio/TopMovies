//
//  AppFlowState.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import ReSwift

enum AppFlowState {
  case launching
  case foreground
  case background
  case terminating
}

extension AppFlowState {
  static func reduce(action: Action, state: AppFlowState) -> AppFlowState {
    switch action {
    case AppFlowAction.applicationDidFinishLaunching, AppFlowAction.applicationWillEnterForeground:
      return .foreground
    case AppFlowAction.applicationDidEnterBackground:
      return .background
    case AppFlowAction.applicationWillTerminate:
      return.terminating
    default: return state
    }
  }
}
