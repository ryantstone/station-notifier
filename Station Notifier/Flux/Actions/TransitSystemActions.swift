import Foundation
import SwiftUIFlux

struct SetLocationsAction: Action {
    let locations: [Location]
    
    init(locations: [Location]) {
        self.locations = locations
    }
}

struct SetFeedsAction: Action {
    let locationID: Int
    let feeds: [Feed]
}
