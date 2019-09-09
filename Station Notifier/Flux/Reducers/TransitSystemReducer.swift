import Foundation
import SwiftUIFlux

func transitSystemReducer(state: TransitSystemState, action: Action) -> TransitSystemState {
    var state = state

    switch action {
    case let action as SetLocationsAction:
        state.locations = Set(action.locations)
    case let action as SetFeedsAction:
        guard var location = state.locations.first(where: { $0.id == action.location.id }) else { break }
        action.feeds.forEach { location.feeds.insert($0) }
        state.locations.insert(location)
    default:
        break
    }
    
    return state
}
