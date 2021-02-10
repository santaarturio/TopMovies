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
        let vc = TopMoviesViewController()
        vc.configureConnection()
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }
}
