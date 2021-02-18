//
//  SeeMoreMoviesCollectionViewCell.swift
//  TopMovies
//
//  Created by Macbook Pro  on 17.02.2021.
//

import UIKit
import SnapKit

class SeeMoreMoviesCollectionViewCell: UICollectionViewCell {
  let seeMoreImageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViewHierarchy()
    setupLayout()
    setupStyle()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViewHierarchy() {
    addSubview(seeMoreImageView)
  }
  private func setupLayout() {
    seeMoreImageView.snp.makeConstraints { make in
      make.top.left.right.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.6)
    }
  }
  private func setupStyle() {
    seeMoreImageView.image = UIImage(named: "seeMore") ?? UIImage()
    seeMoreImageView.contentMode = .scaleAspectFit
  }
}
