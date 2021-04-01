//
//  WelcomeVC.swift
//  TopMovies
//
//  Created by Macbook Pro  on 09.04.2021.
//

import UIKit
import Nuke

struct WelcomeVCProps {
  let services: [Service]; struct Service {
    let serviceBackground: UIImage
    let serviceCellProps: ServiceCellProps
  }
}

final class WelcomeVC: BaseVC<WelcomeVCProps, StoreProvider<MainState>> {
  private let topBackgroundImageView = UIImageView()
  private let servicesCollectionView = UICollectionView(frame: .zero,
                                                        collectionViewLayout: .init())
  private let serviceCellIdentifier = String(describing: ServiceCollectionViewCell.self)
  private lazy var collectionCellSize: CGSize = .init(width: servicesCollectionView.frame.width,
                                                      height: servicesCollectionView.frame.height * 0.6)
  
  private var props = WelcomeVCProps(services: []) {
    didSet {
      servicesCollectionView.reloadData()
      topBackgroundImageView.image = props.services.first?.serviceBackground
    }
  }
  
  override func connect(props: WelcomeVCProps) {
    self.props = props
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewHierarchy()
    setupLayout()
    setupStyle()
  }
  
  private func setupViewHierarchy() {
    [topBackgroundImageView, servicesCollectionView]
      .forEach(view.addSubview(_:))
  }
  private func setupLayout() {
    topBackgroundImageView.snp.makeConstraints { make in
      make.top.left.right.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.3)
    }
    servicesCollectionView.snp.makeConstraints { make in
      make.top.equalTo(topBackgroundImageView.snp.bottom).offset(-32.0)
      make.centerX.bottom.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.8)
    }
  }
  private func setupStyle() {
    view.backgroundColor = Asset.Colors.mainBackground.color
    navigationController?.isNavigationBarHidden = true
    
    topBackgroundImageView.contentMode = .scaleAspectFill
    
    configureCollectionViewLayout()
    servicesCollectionView.layer.cornerRadius = 7.5
    servicesCollectionView.clipsToBounds = true
    servicesCollectionView.backgroundColor = .clear
    servicesCollectionView.showsVerticalScrollIndicator = false
    servicesCollectionView.register(ServiceCollectionViewCell.self,
                                    forCellWithReuseIdentifier: serviceCellIdentifier)
    servicesCollectionView.dataSource = self
    servicesCollectionView.delegate = self
  }
  private func configureCollectionViewLayout() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 0
    servicesCollectionView.collectionViewLayout = layout
  }
}

extension WelcomeVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    props.services.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard
      let cell = collectionView
        .dequeueReusableCell(withReuseIdentifier: serviceCellIdentifier,
                             for: indexPath) as? ServiceCollectionViewCell
    else { return UICollectionViewCell() }
    cell.configure(with: props.services[indexPath.item].serviceCellProps)
    return cell
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForFooterInSection section: Int) -> CGSize {
    .init(width: collectionCellSize.width,
          height: collectionCellSize.height * 0.58)
  }
}

extension WelcomeVC: UICollectionViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    let halfCellOffset = scrollView.contentOffset.y / (collectionCellSize.height / 2)
    let tenths = halfCellOffset - CGFloat(Int(halfCellOffset))
    
    topBackgroundImageView.alpha = (Int(halfCellOffset)) % 2 == 0 ? 1.0 - tenths : tenths
    
    if Int(halfCellOffset) % 2 == 0 {
      let index = Int(halfCellOffset / 2)
      topBackgroundImageView.image = props.services[validated(index)].serviceBackground
    } else {
      let index = Int(halfCellOffset / 2) + 1
      topBackgroundImageView.image = props.services[validated(index)].serviceBackground
    }
  }
  
  private func validated(_ index: Int) -> Int {
    (0..<props.services.count).contains(index) ? index : 0
  }
}

extension WelcomeVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    collectionCellSize
  }
}
