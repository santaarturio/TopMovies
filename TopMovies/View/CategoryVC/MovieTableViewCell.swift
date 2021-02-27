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
  let posterURL: URL?
  let posterPlaceholderImage: UIImage
  let titleLabelText: String
  let releaseDateLabelText: String
  let ratingAndVotesLabelText: String
  let movieIsNew: Bool
  let movieForAdult: Bool
  let descriptionLabeltext: String
}
extension MovieTableViewCellProps {
  init?(movie: Movie?) {
    guard let movie = movie else { return nil }
    posterURL = movie.poster
    posterPlaceholderImage = UIImage(named: "moviePlaceholder") ?? UIImage()
    titleLabelText = movie.title
    releaseDateLabelText = "Release: \(Date.prettyDate(movie.releaseDate))"
    ratingAndVotesLabelText = "\(movie.rating) / 10 out of \(movie.voteCount) votes"
    movieIsNew = MovieTableViewCellProps.isNewMovie(dateString: movie.releaseDate)
    movieForAdult = movie.adult
    descriptionLabeltext = movie.description
  }
  
  static func isNewMovie(dateString: String) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-mm-dd"
    return abs((dateFormatter.date(from: dateString) ?? Date())
                .months(from: Date())) < 3
  }
}

// MARK: - Cell class -
class MovieTableViewCell: UITableViewCell {
  let myContentView = UIView()
  let shadowView = ANShadowView()
  let posterImageView = UIImageView()
  let titleLabel = UILabel()
  let releaseDateLabel = UILabel()
  let titleAndReleaseStackView = UIStackView()
  let descriptionLabel = UILabel()
  let ratingAndVotesLabel = UILabel()
  let infoStackView = UIStackView()
  let isNewImage = UIImageView()
  let isAdultImage = UIImageView()
  let newAndAdultStackView = UIStackView()
  let contentStackView = UIStackView()
  
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
      UIImage(named: "censoredMovie") ?? UIImage() : nil
    isNewImage.image = props.movieIsNew ?
      UIImage(named: "newMovie") ?? UIImage() : nil
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
    
    myContentView.backgroundColor = .white
    myContentView.layer.cornerRadius = 15
    myContentView.clipsToBounds = true
    
    posterImageView.contentMode = .scaleAspectFill
    posterImageView.clipsToBounds = true
    
    titleLabel.font = .boldSystemFont(ofSize: 20)
    titleLabel.textColor = .black
    titleLabel.textAlignment = .left
    titleLabel.numberOfLines = 0
    
    releaseDateLabel.font = .boldSystemFont(ofSize: 13)
    releaseDateLabel.textColor = .darkGray
    releaseDateLabel.textAlignment = .left
    releaseDateLabel.numberOfLines = 0
    
    descriptionLabel.font = .systemFont(ofSize: 14)
    descriptionLabel.textColor = .gray
    descriptionLabel.textAlignment = .left
    descriptionLabel.numberOfLines = 6
    
    ratingAndVotesLabel.font = .boldSystemFont(ofSize: 13)
    ratingAndVotesLabel.textAlignment = .left
    
    isAdultImage.contentMode = .scaleAspectFit
    isNewImage.contentMode = .scaleAspectFit
  }
}
