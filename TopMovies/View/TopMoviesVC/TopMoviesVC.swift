//
//  TopMoviesVC.swift
//  TopMovies
//
//  Created by anikolaenko on 09.02.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TopMoviesVCViewModel {
  private let store: ANStore<MainState>
  private let bag = DisposeBag()
  private let router: RouterProtocol
  
  init(store: ANStore<MainState>, router: RouterProtocol) {
    self.store = store
    self.router = router
  }
  
  func transform(input: Input) -> Output {
    
  }
}
extension TopMoviesVCViewModel {
  struct Input {
    let rechooseServiceAction: ControlEvent<Void>
  }
  struct Output {
    let movieCategories: Observable<[MovieCategoryViewModel]>
  }
}

// MARK: - Props struct
struct TopMoviesProps {
  let movieCategories: [MovieCategoryProps]
  let rechooseServiceAction: () -> Void
}

// MARK: - VC class
final class TopMoviesVC: BaseVC<TopMoviesProps, ANStoreProvider> {
  private var topMoviesProps = TopMoviesProps(movieCategories: [], rechooseServiceAction: { }) {
    didSet {
      movieCategoriesTableView.reloadData()
    }
  }
  private let movieCategoriesTableView = UITableView()
  private let movieCategoryCellIdentifier = String(describing: MovieCategoryTableViewCell.self)
  private let movieCategoryCellIHeight: CGFloat = 220.0
  
  // MARK: - Setup Connection
  override func connect(props: TopMoviesProps) {
    topMoviesProps = props
  }
  
  // MARK: - UISetup
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewHierarchy()
    setupLayout()
    setupStyle()
  }
  private func setupViewHierarchy() {
    view.addSubview(movieCategoriesTableView)
  }
  private func setupLayout() {
    movieCategoriesTableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
  private func setupStyle() {
    view.backgroundColor = Asset.Colors.mainBackground.color
    navigationController?.isNavigationBarHidden = false
    navigationController?.navigationBar.prefersLargeTitles = true
    title = L10n.App.Home.title
    navigationItem.rightBarButtonItem = createRechooseServiceItem()
    
    movieCategoriesTableView.backgroundColor = .clear
    movieCategoriesTableView.separatorStyle = .none
    movieCategoriesTableView.showsVerticalScrollIndicator = false
    movieCategoriesTableView.register(MovieCategoryTableViewCell.self,
                                      forCellReuseIdentifier: movieCategoryCellIdentifier)
    movieCategoriesTableView.dataSource = self
    movieCategoriesTableView.delegate   = self
  }
  private func createRechooseServiceItem() -> UIBarButtonItem {
    let item = UIBarButtonItem(image: Asset.Images.rechooseButton.image,
                               style: .plain,
                               target: self,
                               action: #selector(rechooseServiceSelector(sender:)))
    item.tintColor = Asset.Colors.barButton.color
    return item
  }
  @objc private func rechooseServiceSelector(sender: UIBarButtonItem) {
    topMoviesProps.rechooseServiceAction()
  }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension TopMoviesVC: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    topMoviesProps.movieCategories.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: movieCategoryCellIdentifier,
                                                   for: indexPath) as? MovieCategoryTableViewCell
    else { return UITableViewCell() }
    cell.configure(with: topMoviesProps.movieCategories[indexPath.row])
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    movieCategoryCellIHeight
  }
}
