//
//  MovieCategoryTableViewCell.swift
//  TopMovies
//
//  Created by anikolaenko on 09.02.2021.
//

import UIKit
import SnapKit

// MARK: - Props struct -
struct MovieCategoryProps {
  let categoryNameText: String
  let movies: [MovieCollectionProps]
  let actionAllButton: () -> Void
}
extension MovieCategoryProps {
  init?(categoryNameText: String?,
        movies: [MovieCollectionProps?],
        actionAllButton: @escaping () -> Void) {
    guard let categoryNameText = categoryNameText else { return nil }
    self.categoryNameText = categoryNameText
    self.movies = movies.compactMap { $0 }
    self.actionAllButton = actionAllButton
  }
}
// MARK: - Cell class -
final class MovieCategoryTableViewCell: UITableViewCell {
  private let categoryNameLabel = ANPaddingLabel(withInsets: 0, 8, 0, 8)
  private let moviesCollectionView
    = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
  private let movieCollectionViewCellIdentifier
    = String(describing: MovieCollectionViewCell.self)
  private let seeAllMoviesCollectionCellIdentifier
    = String(describing: SeeAllMoviesCollectionViewCell.self)
  private let infoStackView = UIStackView()
  private var props = MovieCategoryProps(categoryNameText: "",
                                         movies: [],
                                         actionAllButton: { }) {
    didSet { categoryNameLabel.text = props.categoryNameText }
  }
  
  // MARK: Cell configuration
  func configure(with props: MovieCategoryProps) {
    self.props = props
  }
  
  // MARK: - UISetup
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViewHierarchy()
    setupStyle()
    setupLayout()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViewHierarchy() {
    [categoryNameLabel, moviesCollectionView]
      .forEach(infoStackView.addArrangedSubview(_:))
    contentView.addSubview(infoStackView)
  }
  private func configureCollectionViewLayout() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumInteritemSpacing = 0
    moviesCollectionView.collectionViewLayout = layout
  }
  private func setupLayout() {
    infoStackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    categoryNameLabel.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.15)
    }
    configureCollectionViewLayout()
  }
  private func setupStyle() {
    selectionStyle = .none
    backgroundColor = .clear
    
    infoStackView.axis = .vertical
    
    categoryNameLabel.font = .boldSystemFont(ofSize: 22)
    categoryNameLabel.textColor = Asset.Colors.title.color
    categoryNameLabel.textAlignment = .left
    
    moviesCollectionView.backgroundColor = .clear
    moviesCollectionView.dataSource = self
    moviesCollectionView.delegate = self
    moviesCollectionView.register(MovieCollectionViewCell.self,
                                  forCellWithReuseIdentifier: movieCollectionViewCellIdentifier)
    moviesCollectionView.register(SeeAllMoviesCollectionViewCell.self,
                                  forCellWithReuseIdentifier: seeAllMoviesCollectionCellIdentifier)
    moviesCollectionView.showsHorizontalScrollIndicator = false
  }
}
// MARK: - UICollectionViewDataSource
extension MovieCategoryTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    props.movies.count + 1
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.item < props.movies.count {
      guard let cell = collectionView
              .dequeueReusableCell(withReuseIdentifier: movieCollectionViewCellIdentifier,
                                   for: indexPath) as? MovieCollectionViewCell
      else { return UICollectionViewCell() }
      cell.configure(with: props.movies[indexPath.item])
      return cell
    } else {
      guard let cell = collectionView
              .dequeueReusableCell(withReuseIdentifier: seeAllMoviesCollectionCellIdentifier,
                                   for: indexPath) as? SeeAllMoviesCollectionViewCell
      else { return UICollectionViewCell() }
      return cell
    }
  }
}
// MARK: - UICollectionViewDelegate
extension MovieCategoryTableViewCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    indexPath.item == props.movies.count ?
      props.actionAllButton() : props.movies[indexPath.item].actionMovieDetail()
  }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension MovieCategoryTableViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    if indexPath.item < props.movies.count {
      return CGSize(width: collectionView.bounds.width / 2.1,
                    height: collectionView.bounds.height)
    } else {
      return CGSize(width: collectionView.bounds.width / 6.3,
                    height: collectionView.bounds.height)
    }
  }
}
