import Foundation
import Combine
import SwiftUIFlux

struct TransitSystemState: Codable {
    var locations = Set<Location>()
}

