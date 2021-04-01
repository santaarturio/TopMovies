//
//  ServiceCollectionViewCell.swift
//  TopMovies
//
//  Created by Macbook Pro  on 09.04.2021.
//

import UIKit

struct ServiceCellProps {
  let serviceLogoImage: UIImage
  let chooseLabelText: String
  let chooseButtonAction: () -> Void
}

final class ServiceCollectionViewCell: UICollectionViewCell {
  private let containerView = UIView()
  private let shadowView = ANCollectionCellShadowView()
  private let serviceLogoImageView = UIImageView()
  private let chooseLabel = UILabel()
  private let chooseButton = UIButton()
  private let chooseStack = UIStackView()
  
  private var props = ServiceCellProps(serviceLogoImage: .init(),
                                       chooseLabelText: .init(),
                                       chooseButtonAction: { }) {
    didSet {
      chooseLabel.text = props.chooseLabelText
      serviceLogoImageView.image = props.serviceLogoImage
    }
  }
    
  func configure(with props: ServiceCellProps) {
    self.props = props
  }
  
  // MARK: - UISetup
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
    [shadowView, containerView]
      .forEach(addSubview(_:))
    [chooseLabel, chooseButton]
      .forEach(chooseStack.addArrangedSubview(_:))
    [serviceLogoImageView, chooseStack]
      .forEach(containerView.addSubview(_:))
  }
  private func setupLayout() {
    containerView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.width.height.equalToSuperview().multipliedBy(0.95)
    }
    shadowView.snp.makeConstraints { make in
      make.edges.equalTo(containerView)
    }
    serviceLogoImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    chooseStack.snp.makeConstraints { make in
      make.right.bottom.equalToSuperview().offset(-8.0)
      make.width.equalTo(200.0)
      make.height.equalTo(50.0)
    }
    chooseLabel.snp.makeConstraints { make in
      make.width.equalTo(150.0)
    }
  }
  private func setupStyle() {
    containerView.backgroundColor = Asset.Colors.secondaryBackground.color
    containerView.layer.cornerRadius = 7.5
    containerView.clipsToBounds = true
    
    serviceLogoImageView.contentMode = .scaleAspectFit
    
    chooseLabel.font = .boldSystemFont(ofSize: 18.0)
    chooseLabel.textAlignment = .right
    
    chooseButton.setBackgroundImage(Asset.Images.chooseButton.image, for: .normal)
    chooseButton.addTarget(self, action: #selector(chooseButtonSelector(_:)), for: .touchUpInside)
  }
  @objc func chooseButtonSelector(_ sender: UIButton) {
    props.chooseButtonAction()
  }
}
