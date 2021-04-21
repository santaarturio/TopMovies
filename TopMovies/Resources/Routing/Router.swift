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
  @AppProgressStorage(key: AppProgressPassepartout.choosenServiceKey)
  private var choosenService: String?
  
  private var isServiceChoosen: Bool {
    choosenService != nil
  }
  
  func setup(with window: UIWindow?) {
    self.window = window
    self.navigationVC = UINavigationController()
    perform(route: isServiceChoosen ? .allCategories : .welcome)
    self.window?.rootViewController = navigationVC
    self.window?.makeKeyAndVisible()
  }
  
  func perform(route: RouteType) {
    switch route {
    case .welcome:
      let vc = vcFactory.createWelcomeVC()
      let connector = connectorFactory.createWelcomeConnector()
      vc.configureConnection(with: connector)
      navigationVC?.setViewControllers([vc], animated: true)
      
    case .allCategories:
      let vc = vcFactory.createAllCategoriesVC()
      let connector = connectorFactory.createTopMoviesConnector()
      vc.configureConnection(with: connector)
      navigationVC?.setViewControllers([vc], animated: true)
      
    case let .category(categoryId):
      let vc = vcFactory.createCategoryVC()
      let connector = connectorFactory.createCategoryVCConnector(categoryId)
      vc.configureConnection(with: connector)
      navigationVC?.pushViewController(vc, animated: true)
      
    case let .movie(movieId):
      let vc = vcFactory.createMovieVC()
      let connector = connectorFactory.createMovieVCConnector(movieId)
      vc.configureConnection(with: connector)
      navigationVC?.present(vc, animated: true, completion: nil)
      
    case let .dismiss(vc):
      vc.dismiss(animated: true, completion: nil)
    }
  }
}
