//
//  ServicesPassepartout.swift
//  TopMovies
//
//  Created by Macbook Pro  on 10.04.2021.
//

import Foundation

protocol ServicesPassepartoutProtocol {
  func configureApiKey(for service: StreamingService)
}

final class ServicesPassepartout: ServicesPassepartoutProtocol {
  @Inject private var store: AppStore
  
  func configureApiKey(for service: StreamingService) {
    switch service {
    case .quintero: return
    case .tmdb: configureTMDBApiKey()
    }
  }
  
  private func configureTMDBApiKey() {
    var apiKey: String {
      guard let filePath = Bundle.main.path(forResource: "TMDB-Info", ofType: "plist"),
            let plist = NSDictionary(contentsOfFile: filePath),
            let key = plist.object(forKey: "API_KEY") as? String
      else { fatalError("File \"TMDB-Info\" doesn`t exist") }
      return key
    }
    store.dispatch(UpdateConfigurationAction.configureAPIKey(apiKey))
  }
}
