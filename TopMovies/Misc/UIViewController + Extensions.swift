//
//  UIViewController + Extensions.swift
//  TopMovies
//
//  Created by Macbook Pro  on 25.04.2021.
//

import UIKit

extension UIViewController {
  func topMostViewController() -> UIViewController? {
    if self.presentedViewController == nil {
      return self
    }
    if let navigation = self.presentedViewController as? UINavigationController {
      return navigation.visibleViewController?.topMostViewController()
    }
    if let tab = self.presentedViewController as? UITabBarController {
      if let selectedTab = tab.selectedViewController {
        return selectedTab.topMostViewController()
      }
      return tab.topMostViewController()
    }
    return self.presentedViewController?.topMostViewController()
  }
}

extension UIApplication {
  func topMostViewController() -> UIViewController? {
    return self.keyWindow?.rootViewController?.topMostViewController()
  }
}
