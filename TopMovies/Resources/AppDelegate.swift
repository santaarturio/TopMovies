//
//  AppDelegate.swift
//  TopMovies
//
//  Created by Macbook Pro  on 28.01.2021.
//

import ReSwift

typealias MainStore = Store<MainState>

let mainStore = MainStore(reducer: mainReducer, state: nil, middleware: [allActionsMiddleware])

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    Router.shared.setup(with: window)
    configureAPIKey()
    createService()
    
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
    MovieService.shared
    mainStore.dispatch(MovieCategoriesAction.request)
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
