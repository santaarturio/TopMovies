//
//  RouterTransition.swift
//  TopMovies
//
//  Created by Macbook Pro  on 19.03.2021.
//

import UIKit

enum RouteType {
  case welcome
  case allCategories
  case category(MovieCategory.ID)
  case movie(MoviePreview.ID)
  case dismiss(UIViewController)
}
