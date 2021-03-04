//
//  MovieCollectionViewCell.swift
//  TopMovies
//
//  Created by anikolaenko on 08.02.2021.
//

import UIKit
import SnapKit
import Nuke

// MARK: - Props struct -
struct MovieCollectionProps {
  let adultLabelText: String
  let ratingLabelText: String
  let titleLabelText: String
  let descriptionLabeltext: String
  let posterURL: URL?
  let posterPlaceholderImage: UIImage
}

extension MovieCollectionProps {
  init?(movie: Movie?) {
    guard let movie = movie else { return nil }
    adultLabelText = "\(L10n.App.Home.Movie.adult): \(movie.adult ? L10n.App.Home.Movie.yes : L10n.App.Home.Movie.no)"
    ratingLabelText = "\(L10n.App.Home.Movie.rating): \(movie.rating)"
    titleLabelText = movie.title
    descriptionLabeltext = movie.description
    posterURL = movie.poster
    posterPlaceholderImage = Asset.Images.moviePlaceholder.image
  }
}

// MARK: - Cell class -
final class MovieCollectionViewCell: UICollectionViewCell {
  private let posterImageView = UIImageView()
  private let adultLabel = UILabel()
  private let ratingLabel = UILabel()
  private let titleLabel = UILabel()
  private let descriptionLabel = UILabel()
  private let shortInfoStackView = UIStackView()
  private let infoStackView = UIStackView()
  private let shadowView = ANCollectionCellShadowView()
  private let contentStackView = UIStackView()
  private let containerView = UIView()
  // MARK: - Cell configuration
  public func configureWith(props: MovieCollectionProps) {
    posterImageView.image = props.posterPlaceholderImage
    if let url = props.posterURL {
      let options = ImageLoadingOptions(placeholder: props.posterPlaceholderImage,
                                        transition: .fadeIn(duration: 0.2))
      Nuke.loadImage(with: url,
                     options: options,
                     into: posterImageView)
    }
    adultLabel.text = props.adultLabelText
    ratingLabel.text = props.ratingLabelText
    titleLabel.text = props.titleLabelText
    descriptionLabel.text = props.descriptionLabeltext
  }
  // MARK: - UISetup
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViewHierarchy()
    setupLayout()
    setupStyle()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViewHierarchy() {
    [shadowView, containerView]
      .forEach(addSubview(_:))
    [adultLabel, ratingLabel]
      .forEach(shortInfoStackView.addArrangedSubview(_:))
    [shortInfoStackView, titleLabel, descriptionLabel]
      .forEach(infoStackView.addArrangedSubview(_:))
    [posterImageView, infoStackView]
      .forEach(contentStackView.addArrangedSubview(_:))
    containerView.addSubview(contentStackView)
  }
  private func setupLayout() {
    containerView.snp.makeConstraints { make in
      make.centerX.top.equalToSuperview()
      make.height.width.equalToSuperview().offset(-10.0)
    }
    shadowView.snp.makeConstraints { make in
      make.edges.equalTo(containerView)
    }
    contentStackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    posterImageView.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.6)
    }
    infoStackView.layoutMargins = UIEdgeInsets(top: 0,
                                               left: 4,
                                               bottom: 0,
                                               right: 4)
    infoStackView.isLayoutMarginsRelativeArrangement = true
    shortInfoStackView.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.25)
    }
    titleLabel.snp.makeConstraints { make in
      make.height.equalTo(shortInfoStackView)
    }
  }
  private func setupStyle() {
    containerView.backgroundColor = Asset.Colors.secondaryBackground.color
    containerView.layer.cornerRadius = 7.5
    containerView.clipsToBounds = true
    
    contentStackView.axis = .vertical
    infoStackView.axis = .vertical
    shortInfoStackView.axis = .horizontal
    
    posterImageView.contentMode = .scaleAspectFill
    posterImageView.layer.cornerRadius = containerView.layer.cornerRadius
    posterImageView.clipsToBounds = true
    
    adultLabel.textAlignment = .left
    adultLabel.font = .boldSystemFont(ofSize: 12)
    adultLabel.textColor = Asset.Colors.subtitle.color
    
    ratingLabel.textAlignment = .right
    ratingLabel.font = adultLabel.font
    ratingLabel.textColor = adultLabel.textColor
    
    titleLabel.textAlignment = .left
    titleLabel.font = .boldSystemFont(ofSize: 14)
    titleLabel.textColor = Asset.Colors.title.color
    
    descriptionLabel.textAlignment = .left
    descriptionLabel.font = .systemFont(ofSize: 12)
    descriptionLabel.textColor = Asset.Colors.secondaryText.color
    descriptionLabel.numberOfLines = 0
  }
}
