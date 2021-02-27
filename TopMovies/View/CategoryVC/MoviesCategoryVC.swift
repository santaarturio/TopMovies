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
  let categoryId: MovieCategory.ID
  let categoryName: String
  let loadProgress: LoadProgress
  var moviesState: MoviesState
  
  struct LoadProgress {
    let isReloadInProgress: Bool
    let isLoadMoreInProgress: Bool
  }
  struct MoviesState {
    let hasNewData: Bool
    let moviesUsage: RequestType
    var movies: [MovieTableViewCellProps]
  }
}

// MARK: - VC class
class MoviesCategoryVC: UIViewController, PropsConnectable {
  var propsConnector: BaseConnector<MoviesCategoryVCProps>?
  var props = MoviesCategoryVCProps(categoryId: MovieCategory.ID(value: ""),
                                    categoryName: "",
                                    loadProgress: .init(isReloadInProgress: false,
                                                        isLoadMoreInProgress: false),
                                    moviesState: .init(hasNewData: false,
                                                       moviesUsage: .reload,
                                                       movies: [])) {
    didSet {
      title = props.categoryName
      categoryTableView.reloadData()
    }
  }
  private let categoryTableView = UITableView(frame: .zero, style: .grouped)
  private let refreshControl = UIRefreshControl()
  private let footerIndicatorView = UIActivityIndicatorView()
  private let movieCellIdentifier = String(describing: MovieTableViewCell.self)
  private let cellHeight: CGFloat = 200.0
  
  // MARK: - Setup Connection
  public func configureConnectionWith(connector: BaseConnector<MoviesCategoryVCProps>) {
    propsConnector = connector
  }
  public func connect(props: MoviesCategoryVCProps) {
    handleRefresh(props.loadProgress)
    if props.moviesState.hasNewData {
      switch props.moviesState.moviesUsage {
      case .reload:
        self.props = props
      case .loadMore:
        self.props.moviesState.movies += props.moviesState.movies
      }
    }
  }
  // MARK: - Handle Refresh
  private func handleRefresh(_ loadProgress: MoviesCategoryVCProps.LoadProgress) {
    loadProgress.isReloadInProgress ?
      refreshControl.beginRefreshing() : refreshControl.endRefreshing()
    loadProgress.isLoadMoreInProgress ?
      footerIndicatorView.startAnimating() : footerIndicatorView.stopAnimating()
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
    categoryTableView.tableFooterView = footerIndicatorView
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
    refreshControl.attributedTitle = NSAttributedString(string: "Reload in progress...")
    refreshControl.addTarget(self,
                             action: #selector(refreshControlSelector(sender:)),
                             for: .valueChanged)
    
    footerIndicatorView.hidesWhenStopped = true
    footerIndicatorView.color = .blue
  }
  
  // MARK: - Action
  @objc func refreshControlSelector(sender: UIRefreshControl) {
    mainStore.dispatch(RequestedMoviesListAction(categoryId: props.categoryId, requestType: .reload))
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MoviesCategoryVC: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    props.moviesState.movies.count
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
    cell.configure(with: props.moviesState.movies[indexPath.section])
    return cell
  }
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let lastIndexPath = tableView.indexPathsForVisibleRows?.last else { return }
    if lastIndexPath.section <= indexPath.section {
      cell.transform = .init(translationX: 0, y: cellHeight / 4)
      cell.alpha = 0.4
      UIView.animate(withDuration: 0.4, delay: 0, options: [.allowUserInteraction, .curveEaseInOut]) {
        cell.transform = .identity
        cell.alpha = 1.0
      }
    }
  }
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let currentOffset = scrollView.contentOffset.y
    let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
    let deltaOffset = maximumOffset - currentOffset
    
    if deltaOffset <= 0 {
      mainStore.dispatch(RequestedMoviesListAction(categoryId: props.categoryId, requestType: .loadMore))
    }
  }
}
