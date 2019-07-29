import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var locationManager: LocationManager!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window                  = UIWindow(windowScene: windowScene)
            window.rootViewController   = UIHostingController(rootView: ContentView().environmentObject(store))
            self.window                 = window
            
            locationManager = LocationManager(store: store)
            
            window.makeKeyAndVisible()
        }
    }

    
    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}

let store = Store<AppState>(reducer: appStateReducer,
                                 middleware: [],
                                 state: AppState(),
                                 queue: .main)

#if DEBUG
let sampleStore = Store<AppState>(reducer: appStateReducer,
                                  middleware: [],
                                  state: AppState(),
                                  queue: .main)

#endif
