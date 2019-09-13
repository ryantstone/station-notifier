import Foundation
import SwiftUIFlux

func transitSystemReducer(state: TransitSystemState, action: Action) -> TransitSystemState {
    var state = state

    switch action {
    case let action as SetLocationsAction:
        state.locations = action.locations
    case let action as SetFeedsAction:
        guard var location = state.locations.first(where: { $0.id == action.location.id }) else { break }
        action.feeds.forEach { location.feeds.append($0) }
        state.locations.append(location)
    default:
        break
    }
    
    return state
}
