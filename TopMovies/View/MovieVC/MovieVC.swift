//
//  MovieVC.swift
//  TopMovies
//
//  Created by Macbook Pro  on 22.03.2021.
//

import UIKit

struct MovieVCProps { }

class MovieVC: BaseVC<MovieVCProps, StoreProvider<MainState>> {
  private var props = MovieVCProps()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func connect(props: MovieVCProps) { self.props = props }
}
