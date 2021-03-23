//
//  RouterProtocol.swift
//  TopMovies
//
//  Created by Macbook Pro  on 22.03.2021.
//

import UIKit

protocol RouterProtocol {
  func setup(with window: UIWindow?)
  func perform(route: RouteType)
}
