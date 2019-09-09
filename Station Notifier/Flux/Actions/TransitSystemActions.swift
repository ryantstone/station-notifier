import Foundation
import SwiftUIFlux

struct SetLocationsAction: Action {
    let locations: [Location]
    
    init(locations: [Location]) {
        self.locations = locations
    }
}

struct SetFeedsAction: Action {
    let location: Location
    let feeds: [Feed]
}
