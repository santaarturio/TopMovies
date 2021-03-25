//
//  CompanyLogoTableViewCell.swift
//  TopMovies
//
//  Created by anikolaenko on 25.03.2021.
//

import UIKit
import SnapKit
import Nuke

final class CompanyLogoTableViewCell: UITableViewCell {
  private let containerView = UIView()
  let logoImageView = UIImageView()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupViewHierarchy()
    setupLayout()
    setupStyle()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViewHierarchy() {
    contentView.addSubview(containerView)
    containerView.addSubview(logoImageView)
  }
  private func setupLayout() {
    containerView.snp.makeConstraints { make in
      make.center.width.equalToSuperview()
      make.height.equalToSuperview().offset(-8.0)
    }
    logoImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  private func setupStyle() {
    backgroundColor = .clear
    containerView.backgroundColor = .clear
    
    logoImageView.backgroundColor = .clear
    logoImageView.contentMode = .scaleAspectFit
  }
}
