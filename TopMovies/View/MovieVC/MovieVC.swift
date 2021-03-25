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
final class MovieVC: BaseVC<MovieVCProps, StoreProvider<MainState>> {
  private let posterImageView = UIImageView()
  private let isNewImage = UIImageView()
  private let isAdultImage = UIImageView()
  private var productionCompaniesLogos = [URL?]()
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
  
  private let myContentView = UIView()
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewHierarchy()
    setupLayout()
    setupStyle()
    setupLogosTableView()
  }
  
  // MARK: - Connect Props
  override func connect(props: MovieVCProps) {
    if let url = props.posterURL {
      let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.3),
                                        failureImage: props.posterPlaceholderImage)
      Nuke.loadImage(with: url,
                     options: options,
                     into: posterImageView)
    }
    UIView.animate(withDuration: 0.5) { [unowned self] in
      isAdultImage.image = props.isAdultImage
      isNewImage.image = props.isNewImage
      
      productionCompaniesLogos = props.productionCompaniesLogosURL
      titleLabel.text = props.titleLabeltext
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
    
    [isNewImage, isAdultImage]
      .forEach(newAndAdultStackView.addArrangedSubview(_:))
    
    myContentView.addSubview(posterAndDetailsStackView)
    myContentView.addSubview(newAndAdultStackView)
    
    view.addSubview(myContentView)
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
    
    posterImageView.contentMode = .scaleAspectFill
    posterImageView.clipsToBounds = true
    
    titleLabel.font = .boldSystemFont(ofSize: 32)
    titleLabel.textColor = Asset.Colors.title.color
    titleLabel.numberOfLines = 0
    
    taglineLabel.font = .systemFont(ofSize: 24)
    taglineLabel.textColor = Asset.Colors.subtitle.color
    taglineLabel.numberOfLines = 0
    
    overviewTextView.backgroundColor = .clear
    overviewTextView.textContainer.lineFragmentPadding = 0
    overviewTextView.font = .systemFont(ofSize: 16)
    overviewTextView.textColor = Asset.Colors.secondaryText.color
  }
  
  // MARK: - SetupL ayout
  private func setupLayout() {
    myContentView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    posterAndDetailsStackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    posterImageView.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.4)
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
      let cell = tableView.dequeueReusableCell(withIdentifier: logoCellIdentifier) as? CompanyLogoTableViewCell,
      let url = productionCompaniesLogos[indexPath.row]
    else { return UITableViewCell() }
    let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.2),
                                      failureImage: Asset.Images.logoPlaceholder.image)
    Nuke.loadImage(with: url,
                   options: options,
                   into: cell.logoImageView)
    return cell
  }
}
