import Foundation
import MapKit
import SwiftUI

struct Station: Hashable, Identifiable {
    var id: ObjectIdentifier
    
    
    let mapItem: MKMapItem
    let name: String
    let longitude: CLLocationDegrees
    let latitude: CLLocationDegrees

    init?(_ mapItem: MKMapItem) {
        guard let name  = mapItem.name else { return nil }

        self.mapItem    = mapItem
        self.name       = name
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
    init(name: String, latitude: Double, longitude: Double) {
        self.mapItem    = MKMapItem()
        self.longitude  = CLLocationDegrees(exactly: longitude)!
        self.latitude   = CLLocationDegrees(exactly: latitude)!
        self.name       = name
        self.id         = ObjectIdentifier(mapItem)
    }
}
