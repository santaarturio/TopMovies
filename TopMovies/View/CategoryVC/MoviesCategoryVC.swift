//
//  MoviesCategoryVC.swift
//  TopMovies
//
//  Created by Macbook Pro  on 17.02.2021.
//

import UIKit
import SnapKit

// MARK: - Props struct
struct MoviesCategoryVCProps {
  let categoryName: String
  var movies: [MovieTableViewCellProps]
}
extension MoviesCategoryVCProps {
  init?(categoryName: String?, movies: [MovieTableViewCellProps?]) {
    guard let categoryName = categoryName else { return nil }
    self.categoryName = categoryName
    self.movies = movies.compactMap{ $0 }
  }
}

// MARK: - VC class
class MoviesCategoryVC: UIViewController, PropsConnectable {
  typealias Props = MoviesCategoryVCProps
  var propsConnector: BaseConnector<MoviesCategoryVCProps>?
  var props = MoviesCategoryVCProps(categoryName: "", movies: []) {
    didSet {
      title = props.categoryName
      categoryTableView.reloadData()
    }
  }
  private var categoryID: MovieCategory.ID { MovieCategory.ID(value: props.categoryName) }
  private let categoryTableView = UITableView(frame: .zero, style: .grouped)
  private let refreshControl = UIRefreshControl()
  private let movieCellIdentifier = String(describing: MovieTableViewCell.self)
  private let cellHeight: CGFloat = 250.0
  
  // MARK: - Setup Connection
  public func configureConnection(with connector: BaseConnector<MoviesCategoryVCProps>) {
    propsConnector = connector
  }
  public func connect(props: MoviesCategoryVCProps) {
    self.props.movies.isEmpty ?
      self.props = props : self.props.movies.append(contentsOf: props.movies)
  }
  
  // MARK: - UISetup
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewHierarchy()
    setupLayout()
    setupStyle()
  }
  
  private func setupViewHierarchy() {
    view.addSubview(categoryTableView)
    categoryTableView.addSubview(refreshControl)
  }
  private func setupLayout() {
    categoryTableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
  private func setupStyle() {
    navigationController?.navigationBar.prefersLargeTitles = true
    
    categoryTableView.showsVerticalScrollIndicator = false
    categoryTableView.separatorStyle = .none
    categoryTableView.sectionHeaderHeight = 0
    categoryTableView.sectionFooterHeight = 0
    categoryTableView.register(MovieTableViewCell.self,
                               forCellReuseIdentifier: movieCellIdentifier)
    categoryTableView.dataSource = self
    categoryTableView.delegate   = self
    
    refreshControl.tintColor = .blue
    refreshControl.addTarget(self,
                             action: #selector(refreshControlSelector(sender:)),
                             for: .valueChanged)
  }
  
  // MARK: - Action
  @objc func refreshControlSelector(sender: UIRefreshControl) {
    mainStore.dispatch(MoviesRequestAction(categoryId: categoryID, requestType: .reload))
    refreshControl.endRefreshing()
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MoviesCategoryVC: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    props.movies.count
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    1
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    cellHeight
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: movieCellIdentifier)
            as? MovieTableViewCell
    else { return UITableViewCell() }
    cell.configure(with: props.movies[indexPath.section])
    return cell
  }
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.section == tableView.numberOfSections - 1 {
      mainStore.dispatch(MoviesRequestAction(categoryId: categoryID, requestType: .loadMore))
    }
  }
}
