import Foundation
import CoreLocation

class TripState {
    var start: Station?
    var end: Station?
    var intermediateStations: [Station]?
    var lastKnownStop: Station?
    var transitSystem: TransitSystem?
}
