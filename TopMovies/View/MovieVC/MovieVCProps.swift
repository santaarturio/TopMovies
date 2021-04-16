//
//  MovieVCProps.swift
//  TopMovies
//
//  Created by anikolaenko on 25.03.2021.
//

import UIKit

struct MovieVCProps {
  let posterPlaceholderImage: UIImage
  let isDownloadingInProgress: Bool
  let adultImage: UIImage?
  let newImage: UIImage?
  let posterURL: URL?
  let genresLabelTextArray: [String]
  let productionCompaniesLogosURL: [URL?]
  let titleLabelText: String
  let taglineLabelText: String
  let overviewLabelText: String
  let ratingAndVotesLabelText: String
  let budgetLabelText: String
  let statusLabelText: String
  let releaseDateLabelText: String
  let runtimeLabelText: String
  let actionBackButton: (UIViewController) -> Void
}

extension MovieVCProps {
  init(downloadingInProgress: Bool,
       movie: Movie?,
       preview: MoviePreview?,
       actionBackButton: @escaping (UIViewController) -> Void)
  {
    let movie = movie ?? Movie(preview: preview) ?? Movie.defaultValue
    posterPlaceholderImage = Asset.Images.moviePlaceholder.image
    isDownloadingInProgress = downloadingInProgress
    adultImage = movie.adult ?
      Asset.Images.censored.image : nil
    newImage = Date.isNew(date: movie.releaseDate) ?
      Asset.Images.newMovieBottomLabel.image : nil
    posterURL = movie.poster
    genresLabelTextArray = movie.genres
    productionCompaniesLogosURL = movie.productionCompanies.map(\.logo)
    titleLabelText = movie.title
    taglineLabelText = movie.tagline
    overviewLabelText = movie.description
    ratingAndVotesLabelText
      = "\(movie.rating)"
    budgetLabelText = movie.budget > 0 ? "\(movie.budget) $" : L10n.App.MovieDetail.unknownBudget
    statusLabelText = movie.status
    releaseDateLabelText = Date.prettyDateString(from: movie.releaseDate)
    runtimeLabelText = "\(movie.runtime) \(L10n.App.MovieDetail.minutes)"
    self.actionBackButton = actionBackButton
  }
}
