//
//  AppDelegate.swift
//  TopMovies
//
//  Created by Macbook Pro  on 28.01.2021.
//

import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  @Inject var mainStore: MainStore
  @Inject var router: RouterProtocol
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    Assembler.registerDependencies()
    createService()
    configureAPIKey()
    window = UIWindow(frame: UIScreen.main.bounds)
    router.setup(with: window)
    
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
    _ = Container.default.resolver.resolve(MovieService<StoreProvider<MainState>>.self)
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
