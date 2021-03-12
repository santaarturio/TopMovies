//
//  AppDelegate.swift
//  TopMovies
//
//  Created by Macbook Pro  on 28.01.2021.
//

import ReSwift
import Overture

typealias MainStore = Store<MainState>
let mainStore = MainStore(reducer: mainReducer, state: nil, middleware: [allActionsMiddleware])

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var movieService: MovieService<StoreProvider<MainState>>?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    configureAPIKey()
    createService()
    window = UIWindow(frame: UIScreen.main.bounds)
    Router.shared.setup(with: window)
    
    return true
  }
  
  func configureAPIKey() {
    var apiKey: String {
      guard let filePath = Bundle.main.path(forResource: "TMDB-Info", ofType: "plist"),
            let plist = NSDictionary(contentsOfFile: filePath),
            let key = plist.object(forKey: "API_KEY") as? String
      else { fatalError("File \"TMDB-Info\" doesn`t exist") }
      return key
    }
    mainStore.dispatch(UpdateConfigurationAction.configureAPIKey(apiKey))
  }
  func createService() {
    let movieAPI = MovieAPI()
    movieService = MovieService(
      movieAPI: movieAPI,
      storeProvider: curry(StoreProvider<MainState>.init(store: onStateUpdate:))(mainStore)
    )
  }
  func applicationDidFinishLaunching(_ application: UIApplication) {
    mainStore.dispatch(AppFlowAction.applicationDidFinishLaunching)
  }
  func applicationWillEnterForeground(_ application: UIApplication) {
    mainStore.dispatch(AppFlowAction.applicationWillEnterForeground)
  }
  func applicationDidEnterBackground(_ application: UIApplication) {
    mainStore.dispatch(AppFlowAction.applicationDidEnterBackground)
  }
  func applicationWillTerminate(_ application: UIApplication) {
    mainStore.dispatch(AppFlowAction.applicationWillTerminate)
  }
}
