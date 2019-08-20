import SwiftUI
import Combine
import SwiftUIFlux

class AppState: FluxState {

    var willChange = PassthroughSubject<Void, Never>()

    var stationState: StationState      { didSet { willChange.send() } }
    var locationState: LocationState    { didSet { willChange.send() } }
    var tripState: TripState            { didSet { willChange.send() } }
    
    init() {
        locationState   = LocationState()
        stationState    = StationState()
        tripState       = TripState()
    }
}
