import Foundation

func stationReducer(state: StationState, action: Action) -> StationState {
    var state = state
    
    switch action {
    case let action as AddStationsAction: state.set(stations: action.stations)
    default: fatalError()
    }

    return state
}
