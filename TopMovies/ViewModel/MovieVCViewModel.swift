//
//  MovieVCViewModel.swift
//  TopMovies
//
//  Created by Macbook Pro  on 23.04.2021.
//

import Foundation
import RxSwift
import RxCocoa

final class MovieVCViewModel {
  private let movieId: MoviePreview.ID
  
  private let store: ANStore<MainState>
  private let bag = DisposeBag()
  private let router: RouterProtocol
  
  private let posterPlaceholderImage = BehaviorRelay(value: UIImage())
  private let isDownloadingInProgress = BehaviorRelay(value: false)
  private let adultImage = BehaviorRelay<UIImage?>(value: nil)
  private let newImage = BehaviorRelay<UIImage?>(value: nil)
  private let posterURL = BehaviorRelay<URL?>(value: nil)
  private let genresLabelTextArray = BehaviorRelay<[String]>(value: [])
  private let productionCompaniesLogosURL = BehaviorRelay<[URL]>(value: [])
  private let titleLabelText = BehaviorRelay<String>(value: "")
  private let taglineLabelText = BehaviorRelay<String>(value: "")
  private let overviewLabelText = BehaviorRelay<String>(value: "")
  private let ratingAndVotesLabelText = BehaviorRelay<String>(value: "")
  private let budgetLabelText = BehaviorRelay<String>(value: "")
  private let statusLabelText = BehaviorRelay<String>(value: "")
  private let releaseDateLabelText = BehaviorRelay<String>(value: "")
  private let runtimeLabelText = BehaviorRelay<String>(value: "")
  
  init(store: ANStore<MainState>, router: RouterProtocol, movieId: MoviePreview.ID) {
    self.store = store
    self.router = router
    self.movieId = movieId
    
    connectStore()
    
    store.dispatch(RequestMovieUpdateAction.init(movieId: movieId))
  }
  
  private func connectStore() {
    store.observableState
      .subscribe(onNext: { [unowned self] state in
        let moviePreview = state.moviesState.previewsRelational[movieId]
        let movieUpdate = state.moviesState.moviesRelational[movieId]
        
        let movie = movieUpdate ?? Movie(preview: moviePreview) ?? Movie.defaultValue
        
        posterPlaceholderImage.accept(Asset.Images.moviePlaceholder.image)
        isDownloadingInProgress.accept(state.moviesUpdateState.relational[movieId]?.isDownloading ?? false)
        adultImage.accept(movie.adult ?
                            Asset.Images.censored.image : nil)
        newImage.accept(Date.isNew(date: movie.releaseDate) ?
                          Asset.Images.newMovieBottomLabel.image : nil)
        posterURL.accept(movie.poster)
        genresLabelTextArray.accept(movie.genres)
        productionCompaniesLogosURL.accept(movie.productionCompanies.compactMap(\.logo))
        titleLabelText.accept(movie.title)
        taglineLabelText.accept(movie.tagline)
        overviewLabelText.accept(movie.description)
        ratingAndVotesLabelText.accept("\(movie.rating)")
        budgetLabelText.accept(movie.budget > 0 ?
                                "\(movie.budget) $" : L10n.App.MovieDetail.unknownBudget)
        statusLabelText.accept(movie.status)
        releaseDateLabelText.accept(Date.prettyDateString(from: movie.releaseDate))
        runtimeLabelText.accept("\(movie.runtime) \(L10n.App.MovieDetail.minutes)")
      })
      .disposed(by: bag)
  }
  
  func transform(input: Input) -> Output {
    input.actionBackButton.subscribe(onNext: { [unowned self] _ in router.perform(route: .dismiss) })
      .disposed(by: bag)
    return Output.init(posterPlaceholderImage: Observable.just(Asset.Images.moviePlaceholder.image).asDriver(onErrorJustReturn: .init()),
                       isDownloadingInProgress: isDownloadingInProgress.asDriver(),
                       adultImage: adultImage.asDriver(),
                       newImage: newImage.asDriver(),
                       posterURL: posterURL.asObservable(),
                       genresLabelTextArray: genresLabelTextArray.asDriver(),
                       productionCompaniesLogosURL: productionCompaniesLogosURL.asDriver(),
                       titleLabelText: titleLabelText.asDriver(),
                       taglineLabelText: taglineLabelText.asDriver(),
                       overviewLabelText: overviewLabelText.asDriver(),
                       ratingAndVotesLabelText: ratingAndVotesLabelText.asDriver(),
                       budgetLabelText: budgetLabelText.asDriver(),
                       statusLabelText: statusLabelText.asDriver(),
                       releaseDateLabelText: releaseDateLabelText.asDriver(),
                       runtimeLabelText: runtimeLabelText.asDriver())
  }
}

extension MovieVCViewModel {
  struct Input {
    let actionBackButton: ControlEvent<Void>
  }
  struct Output {
    let posterPlaceholderImage: Driver<UIImage>
    let isDownloadingInProgress: Driver<Bool>
    let adultImage: Driver<UIImage?>
    let newImage: Driver<UIImage?>
    let posterURL: Observable<URL?>
    let genresLabelTextArray: Driver<[String]>
    let productionCompaniesLogosURL: Driver<[URL]>
    let titleLabelText: Driver<String>
    let taglineLabelText: Driver<String>
    let overviewLabelText: Driver<String>
    let ratingAndVotesLabelText: Driver<String>
    let budgetLabelText: Driver<String>
    let statusLabelText: Driver<String>
    let releaseDateLabelText: Driver<String>
    let runtimeLabelText: Driver<String>
  }
}
