import Foundation
import SwiftUIFlux

func stationReducer(state: StationState, action: Action) -> StationState {
    let state = state

    switch action {
    case let action as AddStationsAction:
        state.set(action.stations)
    case let action as ReceiveGTFSURL:
        state.set(action.url)
    case let action as AddTransitSystem:
        state.set(action.transitSystem)
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
