import SwiftUI
import Combine
import SwiftUIFlux

class AppState: FluxState, Codable {

    var willChange = PassthroughSubject<Void, Never>()

    var stationState: StationState      { didSet { willChange.send() } }
    var locationState: LocationState    { didSet { willChange.send() } }
    var tripState: TripState            { didSet { willChange.send() } }
    var transitSystemState: TransitSystemState { didSet { willChange.send() }}
    
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

//extension AppState {
//    private enum CodingKeys: String, CodingKey {
//        
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let container = decoder.container(keyedBy: <#T##CodingKey.Protocol#>)
//    }
//}
