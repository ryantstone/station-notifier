import Foundation
import Combine
import MapKit

class StationState {
    var stationList = [Station]()

    func set(stations: [Station]) {
        self.stationList = stations
    }
}
