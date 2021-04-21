//
//  MovieVC.swift
//  TopMovies
//
//  Created by Macbook Pro  on 22.03.2021.
//

import UIKit
import SnapKit
import Nuke

// MARK: - MovieVC -
final class MovieVC: BaseVC<MovieVCProps, ANStoreProvider> {
  private let posterImageView = UIImageView()
  private let posterImageLoader = UIActivityIndicatorView()
  
  private let newMovieImageView = UIImageView()
  private let adultMovieImageView = UIImageView()
  
  private var productionCompaniesLogos = [URL]()
  private let titleLabel = UILabel()
  private let taglineLabel = UILabel()
  
  private let releaseDateTitleLabel = UILabel()
  private let releaseDateLabel = UILabel()
  private let releaseDateStackView = UIStackView()
  
  private let ratingAndVotesTitleLabel = UILabel()
  private let ratingAndVotesLabel = UILabel()
  private let ratingAndVotesStackView = UIStackView()
  
  private let genresTitleLabel = UILabel()
  private let genresLabel = UILabel()
  private let genresStackView = UIStackView()
  
  private let budgetTitleLabel = UILabel()
  private let budgetLabel = UILabel()
  private let budgeStackView = UIStackView()
  
  private let statusTitleLabel = UILabel()
  private let statusLabel = UILabel()
  private let statusStackView = UIStackView()
  
  private let runtimeTitleLabel = UILabel()
  private let runtimeLabel = UILabel()
  private let runtimeStackView = UIStackView()
  
  private let overviewTextView = UITextView()
  
  private let backButton = UIButton()
  
  private let containerView = UIView()
  private let posterAndDetailsStackView = UIStackView()
  private let detailContainerView = UIView()
  private let detailsStackView = UIStackView()
  private let mainDetailsStackView = UIStackView()
  private let secondaryDetailsStackView = UIStackView()
  private let secondaryDetailsLabelsStackView = UIStackView()
  private let newAndAdultStackView = UIStackView()
  private let companiesLogosTableView = UITableView()
  
  private let logoCellIdentifier = String(describing: CompanyLogoTableViewCell.self)
  private let logoCellHeight: CGFloat = 50
  
  private var props: MovieVCProps = .init(downloadingInProgress: false,
                                          movie: nil,
                                          preview: nil,
                                          actionBackButton: { _ in })
  {
    didSet {
      posterImageView.image = props.posterPlaceholderImage
      if let url = props.posterURL {
        posterImageView.image = nil
        posterImageLoader.startAnimating()
        let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.3),
                                          failureImage: props.posterPlaceholderImage)
        Nuke.loadImage(with: url,
                       options: options,
                       into: posterImageView,
                       completion: { [unowned posterImageLoader] _ in posterImageLoader.stopAnimating() })
      }
      UIView.animate(withDuration: 0.5) { [unowned self] in
        adultMovieImageView.image = props.adultImage
        newMovieImageView.image = props.newImage
        
        productionCompaniesLogos = props.productionCompaniesLogosURL.compactMap { $0 }
        titleLabel.text = props.titleLabelText
        taglineLabel.text = props.taglineLabelText
        releaseDateLabel.text = props.releaseDateLabelText
        ratingAndVotesLabel.text = props.ratingAndVotesLabelText
        genresLabel.text = props.genresLabelTextArray.joined(separator: ",\n")
        budgetLabel.text = props.budgetLabelText
        statusLabel.text = props.statusLabelText
        runtimeLabel.text = props.runtimeLabelText
        overviewTextView.text = props.overviewLabelText
      }
      companiesLogosTableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewHierarchy()
    setupLayout()
    setupStyle()
    setupLogosTableView()
  }
  
  // MARK: - Connect Props
  override func connect(props: MovieVCProps) {
    self.props = props
  }
  
  // MARK: - Setup LogosTableView
  private func setupLogosTableView() {
    companiesLogosTableView.backgroundColor = .clear
    companiesLogosTableView.register(CompanyLogoTableViewCell.self, forCellReuseIdentifier: logoCellIdentifier)
    companiesLogosTableView.delegate = self
    companiesLogosTableView.dataSource = self
    companiesLogosTableView.allowsSelection = false
    companiesLogosTableView.showsVerticalScrollIndicator = false
    companiesLogosTableView.separatorStyle = .none
  }
  
  // MARK: - Setup ViewHierarchy
  private func setupViewHierarchy() {
    [releaseDateTitleLabel, releaseDateLabel]
      .forEach(releaseDateStackView.addArrangedSubview(_:))
    [statusTitleLabel, statusLabel]
      .forEach(statusStackView.addArrangedSubview(_:))
    [runtimeTitleLabel, runtimeLabel]
      .forEach(runtimeStackView.addArrangedSubview(_:))
    [ratingAndVotesTitleLabel, ratingAndVotesLabel]
      .forEach(ratingAndVotesStackView.addArrangedSubview(_:))
    [budgetTitleLabel, budgetLabel]
      .forEach(budgeStackView.addArrangedSubview(_:))
    [genresTitleLabel, genresLabel]
      .forEach(genresStackView.addArrangedSubview(_:))
    
    [releaseDateStackView, statusStackView, runtimeStackView, ratingAndVotesStackView, budgeStackView, genresStackView]
      .forEach(secondaryDetailsLabelsStackView.addArrangedSubview(_:))
    
    [secondaryDetailsLabelsStackView, companiesLogosTableView]
      .forEach(secondaryDetailsStackView.addArrangedSubview(_:))
    [titleLabel, taglineLabel, overviewTextView]
      .forEach(mainDetailsStackView.addArrangedSubview(_:))
    [secondaryDetailsStackView, mainDetailsStackView]
      .forEach(detailsStackView.addArrangedSubview(_:))
    detailContainerView.addSubview(detailsStackView)
    
    [posterImageView, detailContainerView]
      .forEach(posterAndDetailsStackView.addArrangedSubview(_:))
    posterImageView.addSubview(posterImageLoader)
    
    [newMovieImageView, adultMovieImageView]
      .forEach(newAndAdultStackView.addArrangedSubview(_:))
    
    containerView.addSubview(posterAndDetailsStackView)
    containerView.addSubview(newAndAdultStackView)
    
    view.addSubview(containerView)
    view.addSubview(backButton)
  }
  
  // MARK: - Setup Style
  private func setupStyle() {
    view.backgroundColor = Asset.Colors.mainBackground.color
    
    posterAndDetailsStackView.axis = .vertical
    posterAndDetailsStackView.spacing = 8.0
    
    detailsStackView.axis = .horizontal
    detailsStackView.spacing = 8.0
    
    secondaryDetailsStackView.axis = .vertical
    
    [releaseDateStackView,
     statusStackView,
     runtimeStackView,
     ratingAndVotesStackView,
     budgeStackView,
     genresStackView].forEach { stack in stack.axis = .vertical }
    
    releaseDateTitleLabel.text = L10n.App.MovieDetail.release + ":"
    statusTitleLabel.text = L10n.App.MovieDetail.status + ":"
    runtimeTitleLabel.text = L10n.App.MovieDetail.runtime + ":"
    ratingAndVotesTitleLabel.text = L10n.App.MovieDetail.rating + ":"
    budgetTitleLabel.text = L10n.App.MovieDetail.budget + ":"
    genresTitleLabel.text = L10n.App.MovieDetail.genres + ":"
    
    [releaseDateTitleLabel,
     statusTitleLabel,
     runtimeTitleLabel,
     ratingAndVotesTitleLabel,
     budgetTitleLabel,
     genresTitleLabel].forEach { label in
      label.font = .boldSystemFont(ofSize: 14)
      label.textColor = Asset.Colors.title.color
      label.textAlignment = .right
     }
    [releaseDateLabel,
     statusLabel,
     runtimeLabel,
     ratingAndVotesLabel,
     budgetLabel,
     genresLabel].forEach { label in
      label.font = .boldSystemFont(ofSize: 14)
      label.textColor = Asset.Colors.subtitle.color
      label.textAlignment = .right
      label.numberOfLines = label.isEqual(genresLabel) ? 0 : 2
     }
    
    secondaryDetailsLabelsStackView.axis = .vertical
    secondaryDetailsLabelsStackView.distribution = .fillProportionally
    secondaryDetailsLabelsStackView.spacing = 8.0
    
    mainDetailsStackView.axis = .vertical
    
    newAndAdultStackView.axis = .horizontal
    newAndAdultStackView.distribution = .fillEqually
    
    newMovieImageView.contentMode = .scaleAspectFit
    newMovieImageView.backgroundColor = .clear
    
    adultMovieImageView.contentMode = .scaleAspectFit
    adultMovieImageView.backgroundColor = .clear
    
    posterImageView.contentMode = .scaleAspectFill
    posterImageView.clipsToBounds = true
    
    posterImageLoader.color = Asset.Colors.refresh.color
    posterImageLoader.hidesWhenStopped = true
    
    titleLabel.font = .boldSystemFont(ofSize: 32)
    titleLabel.textColor = Asset.Colors.title.color
    titleLabel.numberOfLines = 0
    
    taglineLabel.font = .systemFont(ofSize: 24)
    taglineLabel.textColor = Asset.Colors.subtitle.color
    taglineLabel.numberOfLines = 0
    
    overviewTextView.backgroundColor = .clear
    overviewTextView.showsVerticalScrollIndicator = false
    overviewTextView.isEditable = false
    overviewTextView.textContainer.lineFragmentPadding = 0
    overviewTextView.font = .systemFont(ofSize: 16)
    overviewTextView.textColor = Asset.Colors.secondaryText.color
    
    backButton.setBackgroundImage(Asset.Images.close.image, for: .normal)
    backButton.addTarget(self, action: #selector(backButtonSelector), for: .allTouchEvents)
  }
  @objc func backButtonSelector(_ sender: UIButton) {
    props.actionBackButton(self)
  }
  
  // MARK: - SetupL ayout
  private func setupLayout() {
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    posterAndDetailsStackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    posterImageView.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.4)
    }
    newAndAdultStackView.snp.makeConstraints { make in
      make.bottom.equalTo(posterImageView).offset(18.0)
      make.left.equalTo(posterImageView).offset(8.0)
      make.width.equalTo(250)
      make.height.equalTo(50)
    }
    posterImageLoader.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    backButton.snp.makeConstraints { make in
      make.top.left.equalTo(posterImageView).offset(10.0)
      make.width.height.equalTo(36.0)
    }
    detailsStackView.snp.makeConstraints { make in
      make.center.height.equalToSuperview()
      make.width.equalToSuperview().offset(-16.0)
    }
    secondaryDetailsStackView.snp.makeConstraints { make in
      make.width.equalToSuperview().multipliedBy(0.28)
    }
    companiesLogosTableView.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.35)
    }
    [releaseDateTitleLabel,
     statusTitleLabel,
     runtimeTitleLabel,
     ratingAndVotesTitleLabel,
     budgetTitleLabel,
     genresTitleLabel].forEach { label in
      label.snp.makeConstraints { make in
        make.height.equalTo(15)
      }
     }
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource -
extension MovieVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    logoCellHeight
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    productionCompaniesLogos.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(withIdentifier: logoCellIdentifier) as? CompanyLogoTableViewCell
    else { return UITableViewCell() }
    cell.configure(with: productionCompaniesLogos[indexPath.row])
    return cell
  }
}
