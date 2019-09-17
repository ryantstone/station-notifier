import Foundation
import Combine
import SwiftUIFlux

struct TransitSystemState: Codable {
    var locations = [Location]()
    var transitSystems = [String: [TransitSystem]]()
}

