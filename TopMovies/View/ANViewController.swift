//
//  ANViewController.swift
//  TopMovies
//
//  Created by Macbook Pro  on 28.01.2021.
//

import UIKit
import ReSwift

class ANViewController: UIViewController, StoreSubscriber {
    
    typealias StoreSubscriberStateType = MainState
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan
        mainStore.subscribe(self)
    }
 
    func newState(state: MainState) {
        
    }
}
