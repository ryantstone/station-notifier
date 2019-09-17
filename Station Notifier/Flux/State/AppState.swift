import SwiftUI
import Combine
import SwiftUIFlux

class AppState: FluxState, Codable {
    var stationState: StationState
    var locationState: LocationState
    var tripState: TripState
    var transitSystemState: TransitSystemState
    
    init() {
        locationState      = LocationState()
        stationState       = StationState()
        tripState          = TripState()
        transitSystemState = TransitSystemState()
    }
    
    private enum CodingKeys: String, CodingKey {
        case stationState,
        locationState,
        tripState,
        transitSystemState
    }
}
