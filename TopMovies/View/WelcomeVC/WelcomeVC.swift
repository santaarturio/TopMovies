//
//  WelcomeVC.swift
//  TopMovies
//
//  Created by Macbook Pro  on 09.04.2021.
//

import UIKit
import Nuke
import RxSwift
import RxCocoa

struct WelcomeVCProps {
  let services: [Service]; struct Service {
    let serviceBackground: UIImage
    let serviceCellProps: ServiceCellProps
    let chooseServiceAction: () -> Void
  }
  let chooseServiveLabelText: String
  let chooseServiveImage: UIImage
}

final class WelcomeVC: BaseVC<WelcomeVCProps, ANStoreProvider> {
  private let topBackgroundImageView = UIImageView()
  private let servicesCollectionView = UICollectionView(frame: .zero,
                                                        collectionViewLayout: .init())
  private let chooseServiveLabel = UILabel()
  private let chooseServiveImageView = UIImageView()
  private let chooseServiveSpacer = UIView()
  private let chooseServiveStack = UIStackView()
  private let serviceCellIdentifier = String(describing: ServiceCollectionViewCell.self)
  private lazy var collectionCellSize: CGSize = .init(width: servicesCollectionView.frame.width * 0.85,
                                                      height: servicesCollectionView.frame.height)
  private var viewModel: WelcomeVCViewModel!
  private let bag = DisposeBag()
  private var servicesBackground: [UIImage] = []
  private var services: [ServiceCellViewModel] = []
  private var input: WelcomeVCViewModel.Input {
    .init(chooseServiceAction: servicesCollectionView.rx.itemSelected)
  }
  
  override func connect(props: WelcomeVCProps) { }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewHierarchy()
    setupLayout()
    setupStyle()
    
    bindViewModel(output: viewModel.transform(input: input))
  }
  
  private func bindViewModel(output: WelcomeVCViewModel.Output) {
    output.services.drive(onNext: { [unowned self] servicesArray in
      servicesBackground = servicesArray.map(\.serviceBackground)
      services = servicesArray.map(\.serviceCellViewModel)
      servicesCollectionView.reloadData()
    }).disposed(by: bag)
    output.chooseServiveLabelText
      .drive(chooseServiveLabel.rx.text)
      .disposed(by: bag)
    output.chooseServiveImage
      .drive(chooseServiveImageView.rx.image)
      .disposed(by: bag)
  }
  
  private func setupViewHierarchy() {
    [chooseServiveLabel, chooseServiveImageView, chooseServiveSpacer]
      .forEach(chooseServiveStack.addArrangedSubview(_:))
    [topBackgroundImageView, chooseServiveStack, servicesCollectionView]
      .forEach(view.addSubview(_:))
  }
  private func setupLayout() {
    topBackgroundImageView.snp.makeConstraints { make in
      make.top.left.right.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.3)
    }
    servicesCollectionView.snp.makeConstraints { make in
      make.top.equalTo(topBackgroundImageView.snp.bottom).offset(-40)
      make.left.right.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.5)
    }
    chooseServiveStack.snp.makeConstraints { make in
      make.top.equalTo(servicesCollectionView.snp.bottom)
      make.left.equalTo(servicesCollectionView.snp.left).offset(16.0)
      make.right.equalTo(servicesCollectionView.snp.right).offset(-16.0)
      make.height.equalTo(40.0)
    }
  }
  private func setupStyle() {
    view.backgroundColor = Asset.Colors.mainBackground.color
    navigationController?.isNavigationBarHidden = true
    
    topBackgroundImageView.contentMode = .scaleAspectFill
    topBackgroundImageView.clipsToBounds = true
    
    configureCollectionViewLayout()
    servicesCollectionView.layer.cornerRadius = 7.5
    servicesCollectionView.clipsToBounds = true
    servicesCollectionView.layer.masksToBounds = false
    servicesCollectionView.backgroundColor = .clear
    servicesCollectionView.showsHorizontalScrollIndicator = false
    servicesCollectionView.register(ServiceCollectionViewCell.self,
                                    forCellWithReuseIdentifier: serviceCellIdentifier)
    servicesCollectionView.dataSource = self
    servicesCollectionView.delegate = self
    
    chooseServiveLabel.font = .boldSystemFont(ofSize: 18.0)
    chooseServiveLabel.textColor = Asset.Colors.subtitle.color
    
    chooseServiveImageView.contentMode = .scaleAspectFit
  }
  private func configureCollectionViewLayout() {
    var layout = UICollectionViewLayout()
    if #available(iOS 13.0, *) {
      let item = NSCollectionLayoutItem(
        layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                          heightDimension: .fractionalHeight(1.0)))
      let group = NSCollectionLayoutGroup.horizontal(
        layoutSize: .init(widthDimension: .fractionalWidth(0.85),
                          heightDimension: .fractionalHeight(1.0)),
        subitems: [item])
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .groupPaging
      section.contentInsets = .init(top: 0,
                                    leading: 8,
                                    bottom: 0,
                                    trailing: view.bounds.width * 0.15)
      section.visibleItemsInvalidationHandler =
        { [unowned self] _, point, _ in handleScroll(to: point) }
      let compositionalLayout = UICollectionViewCompositionalLayout(section: section)
      layout = compositionalLayout
    } else {
      let flowLayout = UICollectionViewFlowLayout()
      flowLayout.scrollDirection = .horizontal
      flowLayout.minimumLineSpacing = 0
      layout = flowLayout
    }
    servicesCollectionView.collectionViewLayout = layout
  }
}

extension WelcomeVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    services.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard
      let cell = collectionView
        .dequeueReusableCell(withReuseIdentifier: serviceCellIdentifier,
                             for: indexPath) as? ServiceCollectionViewCell
    else { return UICollectionViewCell() }
    cell.connect(viewModel: services[indexPath.item])
    return cell
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForHeaderInSection section: Int) -> CGSize {
    .init(width: 8.0,
          height: collectionCellSize.height)
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForFooterInSection section: Int) -> CGSize {
    .init(width: collectionCellSize.width * 0.17,
          height: collectionCellSize.height)
  }
}

extension WelcomeVC: UICollectionViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    handleScroll(to: scrollView.contentOffset)
  }
  
  private func handleScroll(to point: CGPoint) {
    guard point.x != 0 && point.y == 0 else { return }
    
    let halfCellOffset = point.x / (collectionCellSize.width / 2)
    let tenths = halfCellOffset - CGFloat(Int(halfCellOffset))
    
    topBackgroundImageView.alpha = (Int(halfCellOffset)) % 2 == 0 ? 1.0 - tenths : tenths
    
    if Int(halfCellOffset) % 2 == 0 {
      let index = Int(halfCellOffset / 2)
      topBackgroundImageView.image = servicesBackground[validated(index)]
    } else {
      let index = Int(halfCellOffset / 2) + 1
      topBackgroundImageView.image = servicesBackground[validated(index)]
    }
  }
  private func validated(_ index: Int) -> Int {
    (0..<services.count).contains(index) ? index : services.count - 1
  }
}

extension WelcomeVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    collectionCellSize
  }
}
