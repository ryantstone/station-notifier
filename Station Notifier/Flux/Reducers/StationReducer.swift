import Foundation

func stationReducer(state: StationState, action: Action) -> StationState {
    let state = state

    switch action {
    case let action as AddStationsAction:
        state.set(stations: action.stations)
    case let action as AddLocationAction:
        if let tripEndLocation = store.state.tripState.end?.location {
            if action.location.distance(from: tripEndLocation) <= 100 {
//                store.dispatch(action: <#T##Action#>)
            }
        }
        
        if let startMapItem = store.state.tripState.start?.mapItem {
            print(startMapItem.isCurrentLocation)
        }
    default: ()
    }

    return state
}
