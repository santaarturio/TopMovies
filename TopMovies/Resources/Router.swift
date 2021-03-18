//
//  Router.swift
//  TopMovies
//
//  Created by anikolaenko on 10.02.2021.
//

import UIKit
import Overture

class Router {
  var window : UIWindow?
  var navigationController: UINavigationController?
  
  static let shared = Router()
  
  func setup(with window: UIWindow?) {
    self.window = window
    let startVc = TopMoviesVC()
    startVc.configureConnection(with:
        flip(
          curry(
            TopMoviesConnector
              .init(updateProps: provider: ))
        )(curry(
            StoreProvider<MainState>
              .init(store: onStateUpdate: ))(mainStore))
    )
    navigationController = UINavigationController(rootViewController: startVc)
    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()
  }
  
  enum Route {
    case allCategoriesVC
    case categoryVC(categoryId: MovieCategory.ID)
  }
  func perform(route: Route) {
    switch route {
    case .allCategoriesVC:
      navigationController?.popToRootViewController(animated: true)
    case let .categoryVC(categoryId):
      navigationController?.pushViewController(setupCategoryVC(categoryId),
                                               animated: true)
    }
  }
  
  private func setupCategoryVC(_ categoryId: MovieCategory.ID) -> MoviesCategoryVC {
    let categoryVc = MoviesCategoryVC()
    categoryVc.configureConnection(with:
        flip(
          curry(
            CategoryVCConnector
              .init(categoryId: updateProps: provider: ))(categoryId)
        )(curry(
            StoreProvider<MainState>
              .init(store: onStateUpdate: ))(mainStore))
    )
    return categoryVc
  }
}
