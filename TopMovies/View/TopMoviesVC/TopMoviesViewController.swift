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

// MARK: - VC class
class TopMoviesViewController: UIViewController, PropsConnectable {
  typealias Props = TopMoviesProps
  internal var propsConnector: BaseConnector<Props>?
  private var topMoviesProps = TopMoviesProps(movieCategories: []) {
    didSet {
      movieCategoriesTableView.reloadData()
    }
  }
  private let movieCategoriesTableView = UITableView()
  private let movieCategoryCellIdentifier = String(describing: MovieCategoryTableViewCell.self)
  private let movieCategoryCellIHeight: CGFloat = 200.0
  
  // MARK: - Setup Connection
  public func configureConnection(with connector: BaseConnector<Props>) {
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
    title = "TopMovies"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    movieCategoriesTableView.separatorStyle = .none
    movieCategoriesTableView.showsVerticalScrollIndicator = false
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
    cell.delegate = self
    cell.configure(with: topMoviesProps.movieCategories[indexPath.row],
                   cellID: MovieCategory.ID(value: topMoviesProps.movieCategories[indexPath.row].categoryNameText))
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    movieCategoryCellIHeight
  }
}

extension TopMoviesViewController: MovieCategoryTableViewCellDelegate {
  func movieCategoryTableViewCell(didSelectSeeMoreCellIn categoryID: MovieCategory.ID) {
    let categoryVC = MoviesCategoryVC()
    categoryVC.configureConnection(
      with: MovieCategoryVCConnector(categoryID: categoryID,
                                     updateProps: { [unowned categoryVC] (props) in
                                      categoryVC.connect(props: props)
                                     }))
    navigationController?.pushViewController(categoryVC, animated: true)
  }
}
