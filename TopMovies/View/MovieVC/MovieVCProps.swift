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
  let isAdultImage: UIImage?
  let isNewImage: UIImage?
  let posterURL: URL?
  let genresLabelTextArray: [String]
  let productionCompaniesLogosURL: [URL?]
  let titleLabeltext,
      taglineLabelText,
      overviewLabelText,
      ratingAndVotesLabelText,
      budgetLabelText,
      statusLabelText,
      releaseDateLabelText,
      runtimeLabelText: String
}

extension MovieVCProps {
  init(downloadingInProgress: Bool = true) {
    posterPlaceholderImage = Asset.Images.moviePlaceholder.image
    isDownloadingInProgress = downloadingInProgress
    isAdultImage = nil
    isNewImage = nil
    posterURL = nil
    genresLabelTextArray = [.init()]
    productionCompaniesLogosURL = [nil]
    titleLabeltext = ""
    taglineLabelText = ""
    overviewLabelText = ""
    ratingAndVotesLabelText = ""
    budgetLabelText = ""
    statusLabelText = ""
    releaseDateLabelText = ""
    runtimeLabelText = ""
  }
  init(movie: Movie) {
    posterPlaceholderImage = Asset.Images.moviePlaceholder.image
    isDownloadingInProgress = false
    isAdultImage = movie.adult ?
      Asset.Images.censored.image : nil
    isNewImage = Date.isNew(dateString: movie.releaseDate) ?
      Asset.Images.newMovie.image : nil
    posterURL = movie.poster
    genresLabelTextArray = movie.genres
    productionCompaniesLogosURL = movie.productionCompanies.map(\.logo)
    titleLabeltext = movie.title
    taglineLabelText = movie.tagline
    overviewLabelText = movie.description
    ratingAndVotesLabelText
      = "\(movie.rating) / 10 \(L10n.App.MovieDetail.outOf) \(movie.voteCount) \(L10n.App.MovieDetail.votes)"
    budgetLabelText = movie.budget > 0 ? "\(movie.budget) $" : L10n.App.MovieDetail.unknownBudget
    statusLabelText = "\(movie.status)"
    releaseDateLabelText = "\(Date.prettyDate(movie.releaseDate))"
    runtimeLabelText = "\(movie.runtime) \(L10n.App.MovieDetail.minutes)"
  }
}
