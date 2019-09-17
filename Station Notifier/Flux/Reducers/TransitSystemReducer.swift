import Foundation
import SwiftUIFlux

func transitSystemReducer(state: TransitSystemState, action: Action) -> TransitSystemState {
    var state = state

    switch action {
    case let action as SetLocationsAction:
        state.locations = action.locations
    case let action as SetFeedsAction:
        guard let locationIndex = state.locations.firstIndex(where: { $0.id == action.locationID }) else { break }
        action.feeds.forEach { state.locations[locationIndex].feeds.append($0) }
    case let action as AddTransitSystemAction:
        let id = action.system.feedId
        var transitSystems = state.transitSystems[id] ?? []
        transitSystems.append(action.system)
        state.transitSystems[id] = transitSystems
    default:
        break
    }
    
    return state
}
