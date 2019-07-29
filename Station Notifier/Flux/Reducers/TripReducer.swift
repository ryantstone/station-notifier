import Foundation

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
    default:
        ()
    }

    
    
    
    return state
}
