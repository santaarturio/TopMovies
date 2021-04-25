//
//  WelcomeVCViewModel.swift
//  TopMovies
//
//  Created by Macbook Pro  on 25.04.2021.
//

import RxSwift
import RxCocoa

final class WelcomeVCViewModel {
  private let store: ANStore<MainState>
  private let bag = DisposeBag()
  private let router: RouterProtocol
  @AppProgressStorage(key: AppProgressPassepartout.choosenServiceKey)
  private var choosenService: String?
  
  struct MoviesService {
    let service: StreamingService
    let logoImage: UIImage
    let backgroundImage: UIImage
  }
  private let avaliableServices: [MoviesService]
    = [.init(service: .tmdb,
             logoImage: Asset.Images.tmdbLogo.image,
             backgroundImage: Asset.Images.tmdbBackground.image),
       .init(service: .quintero,
             logoImage: Asset.Images.quinteroLogo.image,
             backgroundImage: Asset.Images.quinteroBackground.image)]
  
  init(store: ANStore<MainState>, router: RouterProtocol) {
    self.store = store
    self.router = router
  }
  
  func transform(input: Input) -> Output {
    input.chooseServiceAction.subscribe(onNext: { [unowned self] indexPath in
      store.dispatch(ChooseServiceAction(service: avaliableServices[indexPath.item].service))
      router.perform(route: .allCategories)
      choosenService = avaliableServices[indexPath.item].service.rawValue
    }).disposed(by: bag)
    
    return Output.init(
      services: Single.just(avaliableServices.map(Output.Service.init(service:)))
        .asDriver(onErrorJustReturn: []),
      chooseServiveLabelText: Driver.just(L10n.App.Welcome.chooseService),
      chooseServiveImage: Driver.just(Asset.Images.chooseButton.image)
    )
  }
}

extension WelcomeVCViewModel {
  struct Input {
    let chooseServiceAction: ControlEvent<IndexPath>
  }
  struct Output {
    let services: Driver<[Service]>; struct Service {
      let serviceBackground: UIImage
      let serviceCellViewModel: ServiceCellViewModel
    }
    let chooseServiveLabelText: Driver<String>
    let chooseServiveImage: Driver<UIImage>
  }
}

private extension WelcomeVCViewModel.Output.Service {
  init(service: WelcomeVCViewModel.MoviesService) {
    serviceBackground = service.backgroundImage
    serviceCellViewModel = .init(serviceLogoImage: Single.just(service.logoImage))
  }
}
