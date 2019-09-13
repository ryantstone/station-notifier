import Foundation
import Combine
import MapKit

class StationState: Codable {
    var stationList = [Station]()
    var transitSystem: TransitSystem?
}
