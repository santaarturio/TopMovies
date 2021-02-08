//
//  AppDelegate.swift
//  TopMovies
//
//  Created by Macbook Pro  on 28.01.2021.
//

import ReSwift

typealias MainStore = Store<MainState>
let mainStore = MainStore(reducer: mainReducer, state: nil) // state is required to be optional

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = ANViewController() // replace it later
        window.makeKeyAndVisible()
        self.window = window
        
        var apiKey: String {
            guard let filePath = Bundle.main.path(forResource: "TMDB-Info", ofType: "plist"),
                  let plist = NSDictionary(contentsOfFile: filePath),
                  let key = plist.object(forKey: "API_KEY") as? String
            else { fatalError("File \"TMDB-Info\" doesn`t exist") }
            return key
        }
        mainStore.dispatch(UpdateConfigurationAction.configureAPIKey(apiKey))
        
        let movieAPI = MovieAPI()
        let movieService = MovieService(movieAPI: movieAPI)
        mainStore.dispatch(MoviesListAction.request)
        return true
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
