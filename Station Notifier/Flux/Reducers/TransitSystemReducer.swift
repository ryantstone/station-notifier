import Foundation
import SwiftUIFlux

func transitSystemReducer(state: TransitSystemState, action: Action) -> TransitSystemState {
    var state = state

    switch action {
    case let action as GetLocationsAction:
        state.locations = action.locations
    default:
        break
    }
    
    return state
}
