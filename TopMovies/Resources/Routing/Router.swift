//
//  Router.swift
//  TopMovies
//
//  Created by Macbook Pro  on 19.03.2021.
//

import UIKit

final class Router: RouterProtocol {
  private(set) var window : UIWindow?
  private var navigationVC: UINavigationController?
  @Inject private var vcFactory: VCFactoryProtocol
  @Inject private var connectorFactory: ConnectorFactoryProtocol
  
  func setup(with window: UIWindow?) {
    self.window = window
    self.navigationVC = UINavigationController()
    perform(route: .allCategories)
    self.window?.rootViewController = navigationVC
    self.window?.makeKeyAndVisible()
  }
  
  func perform(route: RouteType) {
    switch route {
    case .allCategories:
      let vc = vcFactory.createAllCategoriesVC()
      let connector = connectorFactory.createTopMoviesConnector()
      vc.configureConnection(with: connector)
      navigationVC?.setViewControllers([vc], animated: true)
    case let .category(categoryId):
      let vc = vcFactory.createCategoryVC(categoryId)
      let connector = connectorFactory.createCategoryVCConnector(categoryId)
      vc.configureConnection(with: connector)
      navigationVC?.pushViewController(vc, animated: true)
    }
  }
}
