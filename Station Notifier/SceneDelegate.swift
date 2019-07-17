import UIKit
import SwiftUI
import SwiftUIFlux

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    lazy var locationManager = LocationManager(store: store)
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: ContentView().environmentObject(store))
        _ = locationManager
        self.window = window
        window.makeKeyAndVisible()
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
