import Foundation

func appStateReducer(state: AppState, action: Action) -> AppState {
    var state = state
    state.locationState = locationStateReducer(state: state.locationState, action: action)
    return state
}
