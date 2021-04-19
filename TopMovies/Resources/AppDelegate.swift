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
  @AppProgressStorage(key: AppProgressPassepartout.choosenServiceKey)
  private var choosenService: String?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    Assembler.default.registerDependencies()
    checkAppProgress()
    window = UIWindow(frame: UIScreen.main.bounds)
    router.setup(with: window)
    
    return true
  }
  
  func checkAppProgress() {
    choosenService
      .flatMap(StreamingService.init(rawValue:))
      .map(ChooseServiceAction.init(service:))
      .map(mainStore.dispatch(_:))
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
