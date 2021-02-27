//
//  ANShadowView.swift
//  TopMovies
//
//  Created by Macbook Pro  on 27.02.2021.
//

import UIKit

class ANShadowView: UIView {
  
  var setupShadowDone: Bool = false
  
  private func setupShadow() {
    if setupShadowDone { return }
    layer.cornerRadius = 15
    layer.shadowOffset = CGSize(width: 0, height: 5)
    layer.shadowRadius = 4.5
    layer.shadowOpacity = 0.3
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                         byRoundingCorners: .allCorners,
                                         cornerRadii: CGSize(width: 8,
                                                             height: 8)).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
    
    setupShadowDone = true
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupShadow()
  }
}
