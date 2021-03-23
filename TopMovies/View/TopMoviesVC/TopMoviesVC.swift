//
//  TopMoviesVC.swift
//  TopMovies
//
//  Created by anikolaenko on 09.02.2021.
//

import UIKit
import SnapKit

// MARK: - Props struct
struct TopMoviesProps {
  let movieCategories: [MovieCategoryProps]
}

// MARK: - VC class
final class TopMoviesVC: BaseVC<TopMoviesProps, StoreProvider<MainState>> {
  private var topMoviesProps = TopMoviesProps(movieCategories: []) {
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
    title = L10n.App.Home.title
    navigationController?.navigationBar.prefersLargeTitles = true
    
    movieCategoriesTableView.backgroundColor = .clear
    movieCategoriesTableView.separatorStyle = .none
    movieCategoriesTableView.showsVerticalScrollIndicator = false
    movieCategoriesTableView.register(MovieCategoryTableViewCell.self,
                                      forCellReuseIdentifier: movieCategoryCellIdentifier)
    movieCategoriesTableView.dataSource = self
    movieCategoriesTableView.delegate   = self
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
    cell.configureWith(props: topMoviesProps.movieCategories[indexPath.row])
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    movieCategoryCellIHeight
  }
}
