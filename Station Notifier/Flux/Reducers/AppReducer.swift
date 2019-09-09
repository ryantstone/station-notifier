import Foundation
import SwiftUIFlux

func appStateReducer(state: AppState, action: Action) -> AppState {
    var state = state
    
    state.locationState = locationStateReducer(state: state.locationState, action: action)
    state.stationState  = stationReducer(state: state.stationState, action: action)
    state.tripState     = tripReducer(state: state.tripState, action: action)
    state.transitSystemState = transitSystemReducer(state: state.transitSystemState, action: action)
    
    return state
}
