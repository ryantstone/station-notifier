import SwiftUI
import Combine

class AppState: FluxState, BindableObject {

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
