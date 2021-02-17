//
//  MovieCategoryTableViewCell.swift
//  TopMovies
//
//  Created by anikolaenko on 09.02.2021.
//

import UIKit
import SnapKit
// MARK: - MovieCategoryTableViewCellDelegate -
protocol MovieCategoryTableViewCellDelegate: class {
  func movieCategoryTableViewCell(didSelectSeeMoreCellIn categoryID: MovieCategory.ID)
}
// MARK: - Props struct -
struct MovieCategoryProps {
  let categoryNameText: String
  let movies: [MovieCollectionProps]
}
extension MovieCategoryProps {
  init?(categoryNameText: String?, movies: [MovieCollectionProps?]) {
    guard let categoryNameText = categoryNameText else { return nil }
    self.categoryNameText = categoryNameText
    self.movies = movies.compactMap{ $0 }
  }
}
// MARK: - Cell class -
class MovieCategoryTableViewCell: UITableViewCell {
  var cellID: MovieCategory.ID?
  weak var delegate: MovieCategoryTableViewCellDelegate?
  private let categoryNameLabel = UILabel()
  private let moviesCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
  private let movieCollectionViewCellIdentifier
    = String(describing: MovieCollectionViewCell.self)
  private let seeMoreMoviesCollectionViewCellIdentifier
    = String(describing: SeeMoreMoviesCollectionViewCell.self)
  private let movieCollectionInteritemSpacing: CGFloat = 8.0
  private let infoStackView = UIStackView()
  private var moviesProps = [MovieCollectionProps]()
  
  // MARK: Cell configuration
  public func configure(with props: MovieCategoryProps, cellID: MovieCategory.ID) {
    categoryNameLabel.text = props.categoryNameText
    moviesProps = props.movies
    self.cellID = cellID
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
    layout.minimumLineSpacing = 0
    moviesCollectionView.collectionViewLayout = layout
  }
  private func setupLayout() {
    infoStackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    categoryNameLabel.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.1)
    }
    configureCollectionViewLayout()
  }
  private func setupStyle() {
    selectionStyle = .none
    
    infoStackView.axis = .vertical
    
    categoryNameLabel.font = .boldSystemFont(ofSize: 16)
    categoryNameLabel.textAlignment = .left
    
    moviesCollectionView.backgroundColor = .clear
    moviesCollectionView.dataSource = self
    moviesCollectionView.delegate = self
    moviesCollectionView.register(MovieCollectionViewCell.self,
                                  forCellWithReuseIdentifier: movieCollectionViewCellIdentifier)
    moviesCollectionView.register(SeeMoreMoviesCollectionViewCell.self,
                                  forCellWithReuseIdentifier: seeMoreMoviesCollectionViewCellIdentifier)
    moviesCollectionView.showsHorizontalScrollIndicator = false
  }
}
// MARK: - UICollectionViewDataSource
extension MovieCategoryTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    moviesProps.count + 1
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.row < moviesProps.count {
      guard let cell = collectionView
              .dequeueReusableCell(withReuseIdentifier: movieCollectionViewCellIdentifier,
                                   for: indexPath) as? MovieCollectionViewCell
      else { return UICollectionViewCell() }
      cell.configureWith(props: moviesProps[indexPath.item])
      return cell
    } else {
      guard let cell = collectionView
              .dequeueReusableCell(withReuseIdentifier: seeMoreMoviesCollectionViewCellIdentifier,
                                   for: indexPath) as? SeeMoreMoviesCollectionViewCell
      else { return UICollectionViewCell() }
      return cell
    }
  }
}
// MARK: - UICollectionViewDelegate
extension MovieCategoryTableViewCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let cellID = cellID, indexPath.item == moviesProps.count {
      delegate?.movieCategoryTableViewCell(didSelectSeeMoreCellIn: cellID)
    }
  }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension MovieCategoryTableViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: collectionView.bounds.width / 2.2,
           height: collectionView.bounds.height)
  }
}
