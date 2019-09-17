import Foundation
import SwiftUIFlux

func transitSystemReducer(state: TransitSystemState, action: Action) -> TransitSystemState {
    var state = state

    switch action {
    case let action as SetLocationsAction:
        state.locations = action.locations
    case let action as SetFeedsAction:
        guard var locationIndex = state.locations.firstIndex(where: { $0.id == action.locationID }) else { break }
        action.feeds.forEach { state.locations[locationIndex].feeds.append($0) }
    default:
        break
    }
    
    return state
}
