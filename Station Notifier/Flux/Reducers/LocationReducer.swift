import Foundation
import SwiftUIFlux

func locationStateReducer(state: LocationState, action: Action) -> LocationState {
    var state = state

    switch action {
    case let action as AddLocationAction:
        state.add(location: action.location)
    default:
        fatalError()
    }

    return state
}
