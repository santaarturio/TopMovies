//
//  TopMoviesViewController.swift
//  TopMovies
//
//  Created by anikolaenko on 09.02.2021.
//

import UIKit
import SnapKit

struct TopMoviesProps {
    let movieCategories: [MovieCategoryProps]
}

class TopMoviesViewController: UIViewController {
    private let movieCategoriesTableView = UITableView()
    private let movieCategoryCellIdentifier = String(describing: MovieCategoryTableViewCell.self)
    private let movieCategoryCellIHeight: CGFloat = 200.0
    private var movieCategoriesProps = [MovieCategoryProps]()
    
    // MARK: - VC configuration
    public func configureWith(props: TopMoviesProps) {
        movieCategoriesProps = props.movieCategories
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
        view.backgroundColor = .white
        
        movieCategoriesTableView.separatorStyle = .none
        movieCategoriesTableView.register(MovieCategoryTableViewCell.self,
                                          forCellReuseIdentifier: movieCategoryCellIdentifier)
        movieCategoriesTableView.dataSource = self
        movieCategoriesTableView.delegate   = self
    }
}
// MARK: - UITableViewDataSource
extension TopMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieCategoriesProps.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: movieCategoryCellIdentifier,
                                                       for: indexPath) as? MovieCategoryTableViewCell
        else { return UITableViewCell() }
        cell.configureWith(props: movieCategoriesProps[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        movieCategoryCellIHeight
    }
}
