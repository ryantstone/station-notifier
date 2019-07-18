import Foundation
import Combine
import MapKit

class StationState {
    var stationList = [MKMapItem]()

    func set(stations: [MKMapItem]) {
        self.stationList = stations
    }
}
