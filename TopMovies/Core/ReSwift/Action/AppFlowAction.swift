//
//  AppFlowAction.swift
//  TopMovies
//
//  Created by anikolaenko on 02.02.2021.
//

import ReSwift

enum AppFlowAction: ANAction {
  case applicationDidFinishLaunching
  case applicationWillEnterForeground
  case applicationDidEnterBackground
  case applicationWillTerminate
}
