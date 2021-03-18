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
  let isReloadInProgress: Bool
  let isLoadMoreInProgress: Bool
  let movies: [MovieTableViewCellProps]
  let actionReload: () -> Void
  let actionLoadMore: () -> Void
}

// MARK: - VC class
final class MoviesCategoryVC: BaseVC<MoviesCategoryVCProps, StoreProvider<MainState>> {
  var props = MoviesCategoryVCProps(categoryName: "",
                                    isReloadInProgress: false,
                                    isLoadMoreInProgress: false,
                                    movies: [],
                                    actionReload: { },
                                    actionLoadMore: { }) {
    didSet {
      if title == nil { title = props.categoryName }
      handleRefresh(props)
      categoryTableView.reloadData()
    }
  }
  private let categoryTableView = UITableView(frame: .zero, style: .grouped)
  private let refreshControl = UIRefreshControl()
  private let footerIndicatorView = UIActivityIndicatorView(frame: CGRect(origin: .zero,
                                                                          size: .init(width: 40,
                                                                                      height: 40)))
  private let movieCellIdentifier = String(describing: MovieTableViewCell.self)
  private let cellHeight: CGFloat = 200.0
  private var lastAnimatedCellPath = IndexPath()
  
  // MARK: - Setup Connection
  override func connect(props: MoviesCategoryVCProps) {
    self.props = props
  }
  // MARK: - Handle Refresh
  private func handleRefresh(_ props: MoviesCategoryVCProps) {
    props.isReloadInProgress ?
      refreshControl.beginRefreshing() : refreshControl.endRefreshing()
    props.isLoadMoreInProgress ?
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
    view.backgroundColor = Asset.Colors.mainBackground.color
    
    categoryTableView.backgroundColor = .clear
    categoryTableView.showsVerticalScrollIndicator = false
    categoryTableView.separatorStyle = .none
    categoryTableView.sectionHeaderHeight = 0
    categoryTableView.sectionFooterHeight = 0
    categoryTableView.register(MovieTableViewCell.self,
                               forCellReuseIdentifier: movieCellIdentifier)
    categoryTableView.dataSource = self
    categoryTableView.delegate   = self
    
    refreshControl.tintColor = Asset.Colors.refresh.color
    refreshControl.attributedTitle = NSAttributedString(string: "Reload in progress...")
    refreshControl.addTarget(self,
                             action: #selector(refreshControlSelector(sender:)),
                             for: .valueChanged)
    
    footerIndicatorView.hidesWhenStopped = true
    footerIndicatorView.color = refreshControl.tintColor
  }
  
  // MARK: - Action
  @objc func refreshControlSelector(sender: UIRefreshControl) {
    props.actionReload()
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
    guard let lastIndexPath = tableView.indexPathsForVisibleRows?.last else { return }
    if lastIndexPath.section <= indexPath.section && indexPath != lastAnimatedCellPath {
      cell.transform = .init(translationX: 0, y: cellHeight / 4)
      cell.alpha = 0.4
      UIView.animate(withDuration: 0.4, delay: 0, options: [.allowUserInteraction, .curveEaseInOut]) {
        cell.transform = .identity
        cell.alpha = 1.0
      }
      lastAnimatedCellPath = indexPath
    }
  }
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let currentOffset = scrollView.contentOffset.y
    let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
    let deltaOffset = maximumOffset - currentOffset
    
    if deltaOffset <= 0 {
      props.actionLoadMore()
    }
  }
}
