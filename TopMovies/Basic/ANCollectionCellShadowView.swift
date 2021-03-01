//
//  ANCollectionCellShadowView.swift
//  TopMovies
//
//  Created by Macbook Pro  on 27.02.2021.
//

import UIKit

class ANCollectionCellShadowView: UIView {
  
  var setupShadowDone: Bool = false
  
  private func setupShadow() {
    if setupShadowDone { return }
    layer.cornerRadius = 7.5
    layer.shadowOffset = CGSize(width: 0, height: 3)
    layer.shadowRadius = 3
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
