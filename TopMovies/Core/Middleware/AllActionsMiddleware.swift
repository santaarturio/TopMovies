//
//  AllActionsMiddleware.swift
//  TopMovies
//
//  Created by Macbook Pro  on 16.02.2021.
//

import ReSwift

let allActionsMiddleware: Middleware<MainState> = { _, _ in
  return { next in
    return { action in
      #if DEBUG
      print(">  \(action)")
      #endif
      next(action)
    }
  }
}
