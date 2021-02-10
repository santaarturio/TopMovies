//
//  TopMoviesViewController.swift
//  TopMovies
//
//  Created by anikolaenko on 09.02.2021.
//

import UIKit
import SnapKit

protocol PropsConnectable {
  associatedtype Props
  func connect(props: Props)
}

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
    
    private let movieCategoriesTableView = UITableView()
    private let movieCategoryCellIdentifier = String(describing: MovieCategoryTableViewCell.self)
    private let movieCategoryCellIHeight: CGFloat = 200.0
    private var propsConnector: TopMoviesConnector?
    private var movieCategoriesProps = TopMoviesProps() {
        didSet {
            movieCategoriesTableView.reloadData()
        }
    }

    // MARK: - VC configuration
    public func configureConnection() {
        propsConnector = TopMoviesConnector(updateProps: { [unowned self] props in
            connect(props: props)
        })
    }
    func connect(props: TopMoviesProps) {
        movieCategoriesProps = TopMoviesProps(movieCategories: props.movieCategories)
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
        movieCategoriesProps.movieCategories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: movieCategoryCellIdentifier,
                                                       for: indexPath) as? MovieCategoryTableViewCell
        else { return UITableViewCell() }
        cell.configureWith(props: movieCategoriesProps.movieCategories[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        movieCategoryCellIHeight
    }
}
