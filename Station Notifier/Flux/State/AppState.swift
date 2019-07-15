import SwiftUI
import SwiftUIFlux
import Combine

class AppState: FluxState, BindableObject {

    var didChange = PassthroughSubject<Void, Never>()

    var locationState: LocationState {
        didSet { didChange.send() }
    }
    
    init() {
        locationState = LocationState()
    }
}
