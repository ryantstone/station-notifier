import Foundation
import SwiftUIFlux

// MARK: - Actions
// MARK: Get Locations Action
struct GetLocationsAction: AsyncAction {
    func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
        API.shared.transitFeedsAPI.getLocations()
    }
}

// MARK: - Get Feeds
struct GetFeedsAction: AsyncAction {
    let locationId: Int
    
    func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
        API.shared.transitFeedsAPI.getFeeds(locationId: locationId)
    }
}
