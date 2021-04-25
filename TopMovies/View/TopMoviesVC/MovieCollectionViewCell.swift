//
//  MovieCollectionViewCell.swift
//  TopMovies
//
//  Created by anikolaenko on 08.02.2021.
//

import UIKit
import SnapKit
import Nuke
import RxSwift
import RxCocoa

final class MovieCollectionViewModel {
  let movie: MoviePreview
  
  init(movie: MoviePreview) {
    self.movie = movie
  }
  
  func transform() -> Output {
    Output.init(adultLabelText: Driver.just("\(L10n.App.Home.Movie.adult): \(movie.adult ? L10n.App.Home.Movie.yes : L10n.App.Home.Movie.no)"),
                ratingLabelText: Driver.just("\(L10n.App.Home.Movie.rating): \(movie.rating)"),
                titleLabelText: Driver.just(movie.title),
                descriptionLabeltext: Driver.just(movie.description),
                posterURL: Driver.just(movie.poster),
                posterPlaceholderImage: Driver.just(Asset.Images.moviePlaceholder.image))
  }
}
extension MovieCollectionViewModel {
  struct Output {
    let adultLabelText: Driver<String>
    let ratingLabelText: Driver<String>
    let titleLabelText: Driver<String>
    let descriptionLabeltext: Driver<String>
    let posterURL: Driver<URL?>
    let posterPlaceholderImage: Driver<UIImage>
  }
}

// MARK: - Props struct -
struct MovieCollectionProps {
  let movieId: MoviePreview.ID
  let adultLabelText: String
  let ratingLabelText: String
  let titleLabelText: String
  let descriptionLabeltext: String
  let posterURL: URL?
  let posterPlaceholderImage: UIImage
  let actionMovieDetail: () -> Void
}

extension MovieCollectionProps {
  init?(movie: MoviePreview?, actionMovieDetail: @escaping () -> Void) {
    guard let movie = movie else { return nil }
    movieId = movie.id
    adultLabelText = "\(L10n.App.Home.Movie.adult): \(movie.adult ? L10n.App.Home.Movie.yes : L10n.App.Home.Movie.no)"
    ratingLabelText = "\(L10n.App.Home.Movie.rating): \(movie.rating)"
    titleLabelText = movie.title
    descriptionLabeltext = movie.description
    posterURL = movie.poster
    posterPlaceholderImage = Asset.Images.moviePlaceholder.image
    self.actionMovieDetail = actionMovieDetail
  }
}

// MARK: - Cell class -
final class MovieCollectionViewCell: UICollectionViewCell {
  private var viewModel: MovieCollectionViewModel?
  private let bag = DisposeBag()
  
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
  public func connect(viewModel: MovieCollectionViewModel) {
    self.viewModel = viewModel
    bindViewModel()
  }
  private func bindViewModel() {
    guard let output = viewModel?.transform() else { return }
    
    let posterComponents = Driver.combineLatest(output.posterPlaceholderImage, output.posterURL)
    posterComponents.drive(onNext: { [unowned self] placeholder, url in
                                        posterImageView.image = placeholder
                                        if let url = url {
                                          let options = ImageLoadingOptions(placeholder: placeholder,
                                                                            transition: .fadeIn(duration: 0.2))
                                          Nuke.loadImage(with: url,
                                                         options: options,
                                                         into: posterImageView)
                                        }}).disposed(by: bag)
    output.adultLabelText.drive(adultLabel.rx.text)
      .disposed(by: bag)
    output.ratingLabelText.drive(ratingLabel.rx.text)
      .disposed(by: bag)
    output.titleLabelText.drive(titleLabel.rx.text)
      .disposed(by: bag)
    output.descriptionLabeltext.drive(descriptionLabel.rx.text)
      .disposed(by: bag)
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
