import Foundation

func appStateReducer(state: AppState, action: Action) -> AppState {
    var state = state
    
    state.locationState = locationStateReducer(state: state.locationState, action: action)
    state.stationState  = stationReducer(state: state.stationState, action: action)
    state.tripState     = tripReducer(state: state.tripState, action: action)
    
    return state
}
