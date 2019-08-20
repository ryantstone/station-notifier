import Foundation
import SwiftUIFlux

func tripReducer(state: TripState, action: Action) -> TripState {
    var state = state
    
    // MARK: - Helper Functions
    func setIntermediateStations(start: Station?, stop: Station?, stations: [Station]?) {
        if let start        = state.start,
            let end         = state.end,
            let stations    = stations,
            let startIndex  = stations.firstIndex(of: start),
            let endIndex    = stations.firstIndex(of: end) {
            
            let intermediateStations    = stations[startIndex..<endIndex]
            state.intermediateStations  = Array(intermediateStations.dropFirst())
        }
    }
    
    // MARK: - Action Handling
    switch action {
    case let tripAction as AddTripPoint:
        switch tripAction.tripPoint {
        case .start:
            state.start = tripAction.station
            setIntermediateStations(start: state.start,
                                    stop: state.end,
                                    stations: tripAction.stationList)
        case .end:
            state.end = tripAction.station
            
            setIntermediateStations(start: state.start,
                                    stop: state.end,
                                    stations: tripAction.stationList)
        
        default:
            ()
        }
    case let tripAction as AddLocationAction:
        
        guard let currentStation = state
            .intermediateStations?
            .first(where: { tripAction.location.distance(from: $0.location) <= 100 }) else { break }
        
        state.lastKnownStop = currentStation
        if state.lastKnownStop == state.intermediateStations?.last {
            
        }
    default:
        ()
    }

    return state
}
