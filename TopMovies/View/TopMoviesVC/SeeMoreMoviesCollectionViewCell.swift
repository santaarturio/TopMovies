//
//  SeeMoreMoviesCollectionViewCell.swift
//  TopMovies
//
//  Created by Macbook Pro  on 17.02.2021.
//

import UIKit
import SnapKit

class SeeMoreMoviesCollectionViewCell: UICollectionViewCell {
  let seeMoreLabel = UILabel()
  
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
    addSubview(seeMoreLabel)
  }
  private func setupLayout() {
    seeMoreLabel.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  private func setupStyle() {
    seeMoreLabel.text = "See more"
    seeMoreLabel.font = .boldSystemFont(ofSize: 28)
    seeMoreLabel.textAlignment = .justified
  }
}
