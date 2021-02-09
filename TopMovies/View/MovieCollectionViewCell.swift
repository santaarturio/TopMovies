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

// MARK: - Cell class -
class MovieCollectionViewCell: UICollectionViewCell {
    private let posterImageView = UIImageView()
    private let adultLabel = UILabel()
    private let ratingLabel = UILabel()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let shortInfoStackView = UIStackView()
    private let infoStackView = UIStackView()
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
        addSubview(containerView)
        [adultLabel, ratingLabel]
            .forEach(shortInfoStackView.addArrangedSubview(_:))
        [posterImageView, shortInfoStackView, titleLabel, descriptionLabel]
            .forEach(infoStackView.addArrangedSubview(_:))
        containerView.addSubview(infoStackView)
    }
    private func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.center.height.equalToSuperview()
            make.width.equalToSuperview().offset(-8.0)
        }
        infoStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        posterImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        shortInfoStackView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(shortInfoStackView)
        }
    }
    private func setupStyle() {
        infoStackView.axis = .vertical
        shortInfoStackView.axis = .horizontal
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 5
        posterImageView.clipsToBounds = true
        
        adultLabel.textAlignment = .left
        adultLabel.font = .boldSystemFont(ofSize: 12)
        
        ratingLabel.textAlignment = .right
        ratingLabel.font = adultLabel.font
        
        titleLabel.textAlignment = .left
        titleLabel.font = .boldSystemFont(ofSize: 14)
        
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.numberOfLines = 0
    }
}
