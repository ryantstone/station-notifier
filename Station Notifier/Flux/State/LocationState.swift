import Foundation
import Combine
import CoreLocation

struct LocationState: Equatable {
    
    private (set) var location: CLLocation = CLLocation()
    
    var longitude: CLLocationDegrees { location.coordinate.longitude }
    var latitude: CLLocationDegrees { location.coordinate.latitude }
    var timeStamp: Date { location.timestamp }
    var speed: CLLocationSpeed { location.speed }
    var course: CLLocationDirection { location.course }

    mutating func add(location: CLLocation) {
        self.location   = location
    }
}

extension LocationState: Decodable {
    private enum CodingKeys: String, CodingKey {
        case location
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let location = { try? container.decode(Data.self, forKey: .location) }()
            .flatMap({ data in try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? CLLocation }) else {

            throw DecodingError.typeMismatch(Data.self, DecodingError.Context(codingPath: [CodingKeys.location], debugDescription: "Failed to save location"))
        }

        self.location = location
    }
}

extension LocationState: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        let locationData = try NSKeyedArchiver.archivedData(withRootObject: location, requiringSecureCoding: false)
        
        try container.encode(locationData, forKey: .location)
    }
}

