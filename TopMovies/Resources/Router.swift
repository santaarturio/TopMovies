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
    let startVc = TopMoviesViewController()
    startVc.configureConnectionWith(
      connector: TopMoviesConnector(
        updateProps: { [unowned startVc] (props) in
          startVc.connect(props: props)
        },
        provider: curry(StoreProvider<MainState>.init(store: onStateUpdate: ))(mainStore)))
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
    categoryVc.configureConnectionWith(
      connector: CategoryVCConnector(
        categoryId: categoryId,
        updateProps: { [unowned categoryVc] (props) in
          categoryVc.connect(props: props)
        },
        provider: curry(StoreProvider<MainState>.init(store: onStateUpdate: ))(mainStore)))
    return categoryVc
  }
}
