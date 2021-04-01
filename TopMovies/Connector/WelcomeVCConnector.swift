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
      .init(services: [.init(serviceBackground: Asset.Images.tmdbBackground.image,
                             serviceCellProps: .init(serviceLogoImage: Asset.Images.tmdbLogo.image,
                                                     chooseLabelText: L10n.App.Welcome.choose,
                                                     chooseButtonAction: { [unowned self] in
                                                      self.provider.dispatch(ChooseServiceAction(service: .tmdb))
                                                      router.perform(route: .allCategories)
                                                     })),
                       .init(serviceBackground: Asset.Images.quinteroBackground.image,
                             serviceCellProps: .init(serviceLogoImage: Asset.Images.quinteroLogo.image,
                                                     chooseLabelText: L10n.App.Welcome.choose,
                                                     chooseButtonAction: { [unowned self] in
                                                      self.provider.dispatch(ChooseServiceAction(service: .quintero))
                                                      router.perform(route: .allCategories)
                                                     }))
      ]))
  }
  
  override func newState(state: MainState) { }
}
