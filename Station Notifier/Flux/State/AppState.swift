import Foundation
import SwiftUIFlux

struct AppState: FluxState {
    var locationState: LocationState
    
    init() {
        locationState = LocationState()
    }
}
