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
  private let logoImageView = UIImageView()
  private let logoImageLoader = UIActivityIndicatorView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupViewHierarchy()
    setupLayout()
    setupStyle()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with imageURL: URL) {
    let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.3),
                                      failureImage: Asset.Images.logoPlaceholder.image)
    Nuke.loadImage(with: imageURL,
                   options: options,
                   into: logoImageView,
                   progress: { [unowned logoImageLoader] _, current, total in
                    current < total ?
                      logoImageLoader.startAnimating() : logoImageLoader.stopAnimating()
                   })
  }
  
  private func setupViewHierarchy() {
    contentView.addSubview(containerView)
    containerView.addSubview(logoImageView)
    logoImageView.addSubview(logoImageLoader)
  }
  private func setupLayout() {
    containerView.snp.makeConstraints { make in
      make.center.width.equalToSuperview()
      make.height.equalToSuperview().offset(-8.0)
    }
    logoImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    logoImageLoader.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  private func setupStyle() {
    backgroundColor = .clear
    containerView.backgroundColor = .clear
    
    logoImageView.backgroundColor = .clear
    logoImageView.contentMode = .scaleAspectFit
    
    logoImageLoader.color = Asset.Colors.refresh.color
  }
}
