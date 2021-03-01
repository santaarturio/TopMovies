//
//  ANPaddingLabel.swift
//  TopMovies
//
//  Created by Macbook Pro  on 02.03.2021.
//

import UIKit

final class ANPaddingLabel: UILabel {
  private var topInset: CGFloat
  private var bottomInset: CGFloat
  private var leftInset: CGFloat
  private var rightInset: CGFloat
  
  required init(withInsets top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) {
    self.topInset = top
    self.leftInset = left
    self.bottomInset = bottom
    self.rightInset = right
    super.init(frame: CGRect.zero)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawText(in: rect.inset(by: insets))
  }
  override var intrinsicContentSize: CGSize {
    var contentSize = super.intrinsicContentSize
    contentSize.height += topInset + bottomInset
    contentSize.width += leftInset + rightInset
    return contentSize
  }
}
