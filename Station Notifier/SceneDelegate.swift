import UIKit
import SwiftUI
import SwiftUIFlux

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let store = Store(reducer: appStateReducer,
                      middleware: [],
                      state: AppState(),
                      queue: .main)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let contentVM = ContentViewModel(state: state)
        window.rootViewController = UIHostingController(rootView: ContentView(viewModel: contentVM))
        self.window = window
        window.makeKeyAndVisible()
    }

    
    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
