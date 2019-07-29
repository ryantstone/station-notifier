import Foundation
import MapKit
import SwiftUI

struct Station: Hashable, Identifiable, CustomStringConvertible {
    var id: ObjectIdentifier

    let mapItem: MKMapItem
    let name: String
    let longitude: CLLocationDegrees
    let latitude: CLLocationDegrees
    let location: CLLocation?

    init?(_ mapItem: MKMapItem) {
        guard let name  = mapItem.name else { return nil }

        self.mapItem    = mapItem
        self.name       = name
        self.location   = mapItem.placemark.location ?? CLLocation(latitude: mapItem.placemark.coordinate.latitude,
                                                                   longitude: mapItem.placemark.coordinate.longitude)
        self.latitude   = mapItem.placemark.coordinate.longitude
        self.longitude  = mapItem.placemark.coordinate.latitude
        self.id         = ObjectIdentifier(mapItem)
    }
}

extension Station {
    
    /// Initializer for Sample Data
    /// - Parameter name: String value for location name
    /// - Parameter latitude: Latitude
    /// - Parameter longitude: Longitude
    /// - Parameter location: Location
    init(name: String, latitude: Double, longitude: Double, location: CLLocation? = nil) {
        self.mapItem    = MKMapItem()
        self.longitude  = CLLocationDegrees(exactly: longitude)!
        self.latitude   = CLLocationDegrees(exactly: latitude)!
        self.name       = name
        self.id         = ObjectIdentifier(mapItem)
        self.location   = location ?? CLLocation(latitude: latitude, longitude: longitude)
    }
}

extension Station: Equatable {
    static func ==(lhs: Station, rhs: Station) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.longitude == rhs.longitude &&
            lhs.latitude == rhs.latitude &&
            lhs.location == rhs.location
    }
}

extension Station {
    func isNorth(of station: Station) -> Bool {
        return station.latitude < self.latitude
    }
    
    func isSouth(of station: Station) -> Bool {
        return station.latitude > self.latitude
    }
    
    func isWest(of station: Station) -> Bool {
        return station.longitude < self.longitude
    }
    
    func isEast(of station: Station) -> Bool {
        return station.longitude > self.longitude
    }
}
