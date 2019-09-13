import Foundation
import CoreLocation

class TripState: Codable {
    var start: Station?
    var end: Station?
    var intermediateStations: [Station]?
    var lastKnownStop: Station?
    var transitSystem: TransitSystem?
}
