import UIKit
import SwiftUI
import SwiftUIFlux

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var locationManager: LocationManager!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window                  = UIWindow(windowScene: windowScene)
            window.rootViewController   = UIHostingController(rootView: TransitSystemPicker().environmentObject(TransitSystemPickerViewModel(store: store)))
            self.window                 = window
            
            locationManager = LocationManager(store: store)
            
            window.makeKeyAndVisible()
        }
    }

    
    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) {
        appDelegateService.saveState()
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        appDelegateService.getState()
            .flatMap { store.state = $0 }
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        appDelegateService.saveState()
    }
}
private let appDelegateService = AppDelegateService()

let store = Store<AppState>(reducer: appStateReducer,
                                 middleware: [loggingMiddleware],
                                 state: appDelegateService.getState() ??  AppState())

var globalStore: Store<AppState> { return store }
#if DEBUG
let sampleStore = Store<AppState>(reducer: appStateReducer,
                                  middleware: [],
                                  state: AppState())

#endif
