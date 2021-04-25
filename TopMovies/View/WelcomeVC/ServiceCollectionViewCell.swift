//
//  ServiceCollectionViewCell.swift
//  TopMovies
//
//  Created by Macbook Pro  on 09.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class ServiceCellViewModel {
  private let serviceLogoImage: Single<UIImage>
  
  init(serviceLogoImage: Single<UIImage>) {
    self.serviceLogoImage = serviceLogoImage
  }
  
  func transform() -> Output {
    Output.init(serviceLogoImage: serviceLogoImage.asDriver(onErrorJustReturn: .init()))
  }
}
extension ServiceCellViewModel {
  struct Output {
    let serviceLogoImage: Driver<UIImage>
  }
}

struct ServiceCellProps {
  let serviceLogoImage: UIImage
}

final class ServiceCollectionViewCell: UICollectionViewCell {
  private let containerView = UIView()
  private let shadowView = ANCollectionCellShadowView()
  private let serviceLogoImageView = UIImageView()
  override var isHighlighted: Bool {
    didSet {
      UIView.animate(withDuration: 0.1) { [unowned self] in
        self.transform = isHighlighted ?
          .init(scaleX: 0.95, y: 0.95) : .identity }
    }
  }
  private var viewModel: ServiceCellViewModel?
  private let bag = DisposeBag()
  
  private var props = ServiceCellProps(serviceLogoImage: .init()) {
    didSet {
      serviceLogoImageView.image = props.serviceLogoImage
    }
  }
  
  func connect(viewModel: ServiceCellViewModel) {
    self.viewModel = viewModel
    bindViewModel()
  }
  
  private func bindViewModel() {
    viewModel?.transform().serviceLogoImage
      .drive(serviceLogoImageView.rx.image)
      .disposed(by: bag)
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
    containerView.addSubview(serviceLogoImageView)
  }
  private func setupLayout() {
    containerView.snp.makeConstraints { make in
      make.top.left.equalToSuperview().offset(8.0)
      make.right.bottom.equalToSuperview().offset(-8.0)
    }
    shadowView.snp.makeConstraints { make in
      make.edges.equalTo(containerView)
    }
    serviceLogoImageView.snp.makeConstraints { make in
      make.top.left.equalToSuperview().offset(8.0)
      make.right.bottom.equalToSuperview().offset(-8.0)
    }
  }
  private func setupStyle() {
    containerView.backgroundColor = Asset.Colors.secondaryBackground.color
    containerView.layer.cornerRadius = 7.5
    containerView.clipsToBounds = true
    
    serviceLogoImageView.contentMode = .scaleAspectFit
  }
}
