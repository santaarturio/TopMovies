//
//  SeeAllMoviesCollectionViewCell.swift
//  TopMovies
//
//  Created by Macbook Pro  on 17.02.2021.
//

import UIKit
import SnapKit

final class SeeAllMoviesCollectionViewCell: UICollectionViewCell {
  private let seeMoreImageView = UIImageView()
  
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
      make.centerX.top.equalToSuperview()
      make.width.equalToSuperview().offset(-10.0)
      make.height.equalToSuperview().multipliedBy(0.9)
    }
  }
  private func setupStyle() {
    seeMoreImageView.image = UIImage(named: "seeAllMovies") ?? UIImage()
    seeMoreImageView.contentMode = .scaleAspectFit
  }
}
