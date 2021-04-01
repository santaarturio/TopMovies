//
//  MovieTableViewCell.swift
//  TopMovies
//
//  Created by Macbook Pro  on 17.02.2021.
//

import UIKit
import SnapKit
import Nuke

// MARK: - Props struct -
struct MovieTableViewCellProps {
  let movieId: MoviePreview.ID
  let posterURL: URL?
  let posterPlaceholderImage: UIImage
  let titleLabelText: String
  let releaseDateLabelText: String
  let ratingAndVotesLabelText: String
  let movieIsNew: Bool
  let movieForAdult: Bool
  let descriptionLabeltext: String
  let actionMovieDetail: () -> Void
}
extension MovieTableViewCellProps {
  init?(movie: MoviePreview?, actionMovieDetail: @escaping () -> Void) {
    guard let movie = movie else { return nil }
    movieId = movie.id
    posterURL = movie.poster
    posterPlaceholderImage = Asset.Images.moviePlaceholder.image
    titleLabelText = movie.title
    releaseDateLabelText = "\(L10n.App.MovieDetail.release): \(Date.prettyDateString(from: movie.releaseDate))"
    ratingAndVotesLabelText
      = "\(movie.rating) / 10 \(L10n.App.MovieDetail.outOf) \(movie.voteCount) \(L10n.App.MovieDetail.votes)"
    movieIsNew = Date.isNew(date: movie.releaseDate)
    movieForAdult = movie.adult
    descriptionLabeltext = movie.description
    self.actionMovieDetail = actionMovieDetail
  }
}

// MARK: - Cell class -
final class MovieTableViewCell: UITableViewCell {
  private let myContentView = UIView()
  private let shadowView = ANTableCellShadowView()
  private let posterImageView = UIImageView()
  private let titleLabel = UILabel()
  private let releaseDateLabel = UILabel()
  private let titleAndReleaseStackView = UIStackView()
  private let descriptionLabel = UILabel()
  private let ratingAndVotesLabel = UILabel()
  private let infoStackView = UIStackView()
  private let isNewImage = UIImageView()
  private let isAdultImage = UIImageView()
  private let newAndAdultStackView = UIStackView()
  private let contentStackView = UIStackView()
  
  // MARK: - Cell configuration
  public func configure(with props: MovieTableViewCellProps) {
    posterImageView.image = props.posterPlaceholderImage
    if let url = props.posterURL {
      let options = ImageLoadingOptions(placeholder: props.posterPlaceholderImage,
                                        transition: .fadeIn(duration: 0.2))
      Nuke.loadImage(with: url,
                     options: options,
                     into: posterImageView)
    }
    titleLabel.text = props.titleLabelText
    releaseDateLabel.text = props.releaseDateLabelText
    ratingAndVotesLabel.text = props.ratingAndVotesLabelText
    descriptionLabel.text = props.descriptionLabeltext
    isAdultImage.image = props.movieForAdult ?
      Asset.Images.censored.image : nil
    isNewImage.image = props.movieIsNew ?
      Asset.Images.newMovie.image : nil
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
    addSubview(shadowView)
    [titleLabel, releaseDateLabel]
      .forEach(titleAndReleaseStackView.addArrangedSubview(_:))
    [titleAndReleaseStackView, descriptionLabel, ratingAndVotesLabel]
      .forEach(infoStackView.addArrangedSubview(_:))
    [posterImageView, infoStackView]
      .forEach(contentStackView.addArrangedSubview(_:))
    myContentView.addSubview(contentStackView)
    addSubview(myContentView)
    [isNewImage, isAdultImage]
      .forEach(newAndAdultStackView.addArrangedSubview(_:))
    addSubview(newAndAdultStackView)
  }
  private func setupLayout() {
    myContentView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.width.equalToSuperview().offset(-32.0)
      make.height.equalToSuperview().offset(-16.0)
    }
    shadowView.snp.makeConstraints { make in
      make.edges.equalTo(myContentView)
    }
    contentStackView.snp.makeConstraints { make in
      make.top.left.bottom.equalToSuperview()
      make.right.equalToSuperview().offset(-8.0)
    }
    posterImageView.snp.makeConstraints { make in
      make.width.equalTo(posterImageView.snp.height).multipliedBy(0.7)
    }
    newAndAdultStackView.snp.makeConstraints { make in
      make.top.left.equalTo(posterImageView).offset(-6.0)
      make.height.equalTo(50)
      make.width.equalTo(100)
    }
    infoStackView.layoutMargins = UIEdgeInsets(top: 8.0,
                                               left: 8.0,
                                               bottom: 8.0,
                                               right: 8.0)
    infoStackView.isLayoutMarginsRelativeArrangement = true
    titleAndReleaseStackView.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.2)
    }
    descriptionLabel.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.6)
    }
  }
  private func setupStyle() {
    selectionStyle = .none
    backgroundColor = .clear
    
    contentStackView.axis = .horizontal
    titleAndReleaseStackView.axis = .vertical
    titleAndReleaseStackView.distribution = .fillProportionally
    newAndAdultStackView.axis = .horizontal
    newAndAdultStackView.distribution = .fillEqually
    infoStackView.axis = .vertical
    
    myContentView.backgroundColor = Asset.Colors.secondaryBackground.color
    myContentView.layer.cornerRadius = 15
    myContentView.clipsToBounds = true
    
    posterImageView.contentMode = .scaleAspectFill
    posterImageView.clipsToBounds = true
    
    titleLabel.font = .boldSystemFont(ofSize: 20)
    titleLabel.textColor = Asset.Colors.title.color
    titleLabel.textAlignment = .left
    
    releaseDateLabel.font = .boldSystemFont(ofSize: 13)
    releaseDateLabel.textColor = Asset.Colors.subtitle.color
    releaseDateLabel.textAlignment = .left
    
    descriptionLabel.font = .systemFont(ofSize: 14)
    descriptionLabel.textColor = Asset.Colors.secondaryText.color
    descriptionLabel.textAlignment = .left
    descriptionLabel.numberOfLines = 6
    
    ratingAndVotesLabel.font = .boldSystemFont(ofSize: 13)
    ratingAndVotesLabel.textColor = Asset.Colors.subtitle.color
    ratingAndVotesLabel.textAlignment = .left
    
    isAdultImage.contentMode = .scaleAspectFit
    isNewImage.contentMode = .scaleAspectFit
  }
}
