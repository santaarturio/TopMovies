//
//  WelcomeVCConnector.swift
//  TopMovies
//
//  Created by Macbook Pro  on 09.04.2021.
//

import Foundation

final class WelcomeVCConnector<Provider: StoreProviderProtocol>: BaseConnector<WelcomeVCProps, Provider>
where Provider.ExpectedStateType == MainState {
  @Inject private var router: RouterProtocol
  
  override init(updateProps: @escaping (BaseConnector<WelcomeVCProps, Provider>.Props) -> Void,
                provider: (@escaping BaseConnector<WelcomeVCProps, Provider>.StateUpdate) -> Provider) {
    super.init(updateProps: updateProps, provider: provider)
    
    updateProps(
      .init(services: [
        .init(serviceBackground: Asset.Images.tmdbBackground.image,
              serviceCellProps: .init(serviceLogoImage: Asset.Images.tmdbLogo.image),
              chooseServiceAction: { [unowned self] in
                self.provider.dispatch(ChooseServiceAction(service: .tmdb))
                router.perform(route: .allCategories)
              }),
        .init(serviceBackground: Asset.Images.quinteroBackground.image,
              serviceCellProps: .init(serviceLogoImage: Asset.Images.quinteroLogo.image),
              chooseServiceAction: { [unowned self] in
                self.provider.dispatch(ChooseServiceAction(service: .quintero))
                router.perform(route: .allCategories)
              })
      ],
      chooseServiveLabelText: L10n.App.Welcome.chooseService,
      chooseServiveImage: Asset.Images.chooseButton.image))
  }
  
  override func newState(state: MainState) { }
}
