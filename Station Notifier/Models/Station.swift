import Foundation
import MapKit
import SwiftUI

struct Station: Hashable, Identifiable, CustomStringConvertible {
    var id: MKMapItem
    let mapItem: MKMapItem
    let name: String
    let longitude: CLLocationDegrees
    let latitude: CLLocationDegrees
    let location: CLLocation

    init?(_ mapItem: MKMapItem) {
        guard let name  = mapItem.name else { return nil }

        self.mapItem    = mapItem
        self.name       = name
        self.location   = mapItem.placemark.location ?? CLLocation(latitude: mapItem.placemark.coordinate.latitude,
                                                                   longitude: mapItem.placemark.coordinate.longitude)
        self.latitude   = mapItem.placemark.coordinate.longitude
        self.longitude  = mapItem.placemark.coordinate.latitude
        self.id         = mapItem
    }
}

extension Station {
    init(name: String, latitude: Double, longitude: Double, location: CLLocation? = nil) {
        self.mapItem    = MKMapItem()
        self.longitude  = CLLocationDegrees(exactly: longitude)!
        self.latitude   = CLLocationDegrees(exactly: latitude)!
        self.name       = name
        self.id         = mapItem
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

extension Station: Decodable {
    private enum CodingKeys: String, CodingKey {
        case
        id,
        mapItem,
        name,
        longitude,
        latitude,
        location
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        
        guard let mapItem = { try? container.decode(Data.self, forKey: .mapItem) }()
            .flatMap({ data in try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? MKMapItem }) else {
                
            throw DecodingError.typeMismatch(Data.self, DecodingError.Context(codingPath: [CodingKeys.mapItem], debugDescription: "Failed to save map item"))
        }
        
        guard let longitude = { try? container.decode(Data.self, forKey: .longitude) }()
            .flatMap({ data in try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? CLLocationDegrees }) else {
                
            throw DecodingError.typeMismatch(Data.self, DecodingError.Context(codingPath: [CodingKeys.longitude], debugDescription: "Failed to save longitude"))
        }
        
        guard let lattitude = { try? container.decode(Data.self, forKey: .latitude) }()
            .flatMap({ data in try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? CLLocationDegrees }) else {
                
                throw DecodingError.typeMismatch(Data.self, DecodingError.Context(codingPath: [CodingKeys.latitude], debugDescription: "Failed to save latitude"))
        }
        
        guard let location = { try? container.decode(Data.self, forKey: .location) }()
            .flatMap({ data in try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? CLLocation }) else {
                
                throw DecodingError.typeMismatch(Data.self, DecodingError.Context(codingPath: [CodingKeys.location], debugDescription: "Failed to save location"))
        }

        self.latitude = lattitude
        self.longitude = longitude
        self.location = location
        self.mapItem = mapItem
        self.id = mapItem
    }
}

extension Station: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        let idData = try NSKeyedArchiver.archivedData(withRootObject: id, requiringSecureCoding: false)
        let latitudeData = try NSKeyedArchiver.archivedData(withRootObject: latitude, requiringSecureCoding: false)
        let longitudeData = try NSKeyedArchiver.archivedData(withRootObject: longitude, requiringSecureCoding: false)
        let mapItemData = try NSKeyedArchiver.archivedData(withRootObject: mapItem, requiringSecureCoding: false)
        let locationData = try NSKeyedArchiver.archivedData(withRootObject: location, requiringSecureCoding: false)

        try container.encode(locationData, forKey: .location)
        try container.encode(idData, forKey: .id)
        try container.encode(latitudeData, forKey: .latitude)
        try container.encode(longitudeData, forKey: .longitude)
        try container.encode(mapItemData, forKey: .mapItem)
        try container.encode(name, forKey: .name)
    }
}
