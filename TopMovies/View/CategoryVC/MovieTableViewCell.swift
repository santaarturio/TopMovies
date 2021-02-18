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
  let ratingLabelText: String
  let voteCountLabelText: String
  let adultLabelText: String
  let descriptionLabeltext: String
}
extension MovieTableViewCellProps {
  init?(movie: Movie?) {
    guard let movie = movie else { return nil }
    posterURL = movie.poster
    posterPlaceholderImage = UIImage(named: "moviePlaceholder") ?? UIImage()
    titleLabelText = movie.title
    releaseDateLabelText = "Release: \(Date.prettyDate(movie.releaseDate))"
    ratingLabelText = "Rating: \(movie.rating)"
    voteCountLabelText = "Vote count: \(movie.voteCount)"
    adultLabelText = "Adult: \(movie.adult ? "Yes" : "No")"
    descriptionLabeltext = movie.description
  }
}

// MARK: - Cell class -
class MovieTableViewCell: UITableViewCell {
  let myContentView = UIView()
  let posterImageView = UIImageView()
  let titleLabel = UILabel()
  let releaseDateLabel = UILabel()
  let titleAndReleaseStackView = UIStackView()
  let ratingLabel = UILabel()
  let voteCountLabel = UILabel()
  let adultLabel = UILabel()
  let ratingVotesAdultStackView = UIStackView()
  let descriptionLabel = UILabel()
  let infoStackView = UIStackView()
  let contentStackView = UIStackView()
  
  // MARK: Cell configuration
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
    ratingLabel.text = props.ratingLabelText
    voteCountLabel.text = props.voteCountLabelText
    adultLabel.text = props.adultLabelText
    descriptionLabel.text = props.descriptionLabeltext
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
    [titleLabel, releaseDateLabel]
      .forEach(titleAndReleaseStackView.addArrangedSubview(_:))
    [ratingLabel, voteCountLabel, adultLabel]
      .forEach(ratingVotesAdultStackView.addArrangedSubview(_:))
    [titleAndReleaseStackView, descriptionLabel, ratingVotesAdultStackView]
      .forEach(infoStackView.addArrangedSubview(_:))
    [posterImageView, infoStackView]
      .forEach(contentStackView.addArrangedSubview(_:))
    myContentView.addSubview(contentStackView)
    addSubview(myContentView)
  }
  private func setupLayout() {
    myContentView.snp.makeConstraints { make in
      make.center.width.equalToSuperview()
      make.height.equalToSuperview().offset(-20.0)
    }
    contentStackView.snp.makeConstraints { make in
      make.top.left.bottom.equalToSuperview()
      make.right.equalToSuperview().offset(-4.0)
    }
    posterImageView.snp.makeConstraints { make in
      make.width.equalToSuperview().multipliedBy(0.35)
    }
    titleAndReleaseStackView.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.2)
    }
    descriptionLabel.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.7)
    }
  }
  private func setupStyle() {
    selectionStyle = .none
    backgroundColor = .clear
    
    contentStackView.axis = .horizontal
    contentStackView.spacing = 4.0
    titleAndReleaseStackView.axis = .vertical
    titleAndReleaseStackView.distribution = .fillProportionally
    ratingVotesAdultStackView.axis = .horizontal
    ratingVotesAdultStackView.distribution = .equalSpacing
    infoStackView.axis = .vertical
    
    myContentView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
    myContentView.layer.cornerRadius = 12.5
    myContentView.clipsToBounds = true
    
    posterImageView.contentMode = .scaleAspectFill
    posterImageView.clipsToBounds = true
    
    titleLabel.font = .boldSystemFont(ofSize: 20)
    titleLabel.textAlignment = .left
    titleLabel.numberOfLines = 0
    
    releaseDateLabel.font = .boldSystemFont(ofSize: 12)
    releaseDateLabel.textAlignment = .left
    releaseDateLabel.numberOfLines = 0
    
    descriptionLabel.font = .systemFont(ofSize: 12)
    descriptionLabel.textAlignment = .left
    descriptionLabel.numberOfLines = 0
    
    ratingLabel.font = .boldSystemFont(ofSize: 12)
    ratingLabel.textAlignment = .center
    
    voteCountLabel.font = ratingLabel.font
    voteCountLabel.textAlignment = .center
    
    adultLabel.font = ratingLabel.font
    adultLabel.textAlignment = .center
  }
}

extension Date {
  static func prettyDate(_ date: String) -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-mm-dd"
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "MMM, dd - yyyy"
    return dateFormatterPrint.string(from: dateFormatterGet.date(from: date)  ?? Date())
  }
}
