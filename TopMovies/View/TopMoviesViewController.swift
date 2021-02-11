//
//  TopMoviesViewController.swift
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
extension TopMoviesProps {
  init() {
    self.init(movieCategories: [])
  }
}

// MARK: - VC class
class TopMoviesViewController: UIViewController, PropsConnectable {
  typealias Props = TopMoviesProps
  internal var propsConnector: BaseConnector<Props>?
  private var topMoviesProps = TopMoviesProps() {
    didSet {
      movieCategoriesTableView.reloadData()
    }
  }
  private let movieCategoriesTableView = UITableView()
  private let movieCategoryCellIdentifier = String(describing: MovieCategoryTableViewCell.self)
  private let movieCategoryCellIHeight: CGFloat = 200.0
  
  // MARK: - Setup Connection
  public func configureConnectionWith(connector: BaseConnector<Props>) {
    propsConnector = connector
  }
  internal func connect(props: Props) {
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
    movieCategoriesTableView.separatorStyle = .none
    movieCategoriesTableView.register(MovieCategoryTableViewCell.self,
                                      forCellReuseIdentifier: movieCategoryCellIdentifier)
    movieCategoriesTableView.dataSource = self
    movieCategoriesTableView.delegate   = self
  }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension TopMoviesViewController: UITableViewDataSource, UITableViewDelegate {
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