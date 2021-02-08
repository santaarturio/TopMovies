//
//  MovieCollectionViewCell.swift
//  TopMovies
//
//  Created by anikolaenko on 08.02.2021.
//

import UIKit
import SnapKit
import Nuke

class MovieCollectionViewCell: UICollectionViewCell {
    private let posterImage = UIImageView()
    private let adultLabel = UILabel()
    private let ratingLabel = UILabel()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let shortInfoStackView = UIStackView()
    private let infoStackView = UIStackView()
    
    public func configureWith(movie: Movie) {
        if let url = movie.poster { Nuke.loadImage(with: url, into: posterImage) }
        adultLabel.text = "Adult: \(movie.adult ? "Yes" : "No")"
        ratingLabel.text = String(movie.rating)
        titleLabel.text = movie.title
        descriptionLabel.text = movie.description
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewHierarchy()
        setupLayout()
        setupStyle()
    }
    
    private func setupViewHierarchy() {
        shortInfoStackView.addArrangedSubview(adultLabel)
        shortInfoStackView.addArrangedSubview(ratingLabel)
        
        infoStackView.addArrangedSubview(posterImage)
        infoStackView.addArrangedSubview(shortInfoStackView)
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(descriptionLabel)
        
        addSubview(infoStackView)
    }
    private func setupLayout() {
        infoStackView.axis = .vertical
        shortInfoStackView.axis = .horizontal
        
        infoStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        posterImage.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        shortInfoStackView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(shortInfoStackView)
        }
    }
    private func setupStyle() {
        posterImage.contentMode = .scaleAspectFill
        posterImage.layer.cornerRadius = 15.0
        
        adultLabel.textAlignment = .left
        adultLabel.font = .boldSystemFont(ofSize: 12)
        
        ratingLabel.textAlignment = .right
        ratingLabel.font = adultLabel.font
        
        titleLabel.textAlignment = .center
        titleLabel.font = .italicSystemFont(ofSize: 16)
        
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = .systemFont(ofSize: 12)
    }
}
