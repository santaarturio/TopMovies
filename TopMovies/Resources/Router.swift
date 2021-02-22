//
//  Router.swift
//  TopMovies
//
//  Created by anikolaenko on 10.02.2021.
//

import UIKit

class Router {
  var window : UIWindow?
  
  static let shared = Router()
  
  func setup(with window: UIWindow?) {
    self.window = window
    let startVc = TopMoviesViewController()
    let navigationController = UINavigationController(rootViewController: startVc)
    startVc.configureConnectionWith(
      connector: TopMoviesConnector(
        updateProps: { [unowned startVc] (props) in
          startVc.connect(props: props)
        }))
    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()
  }
}
