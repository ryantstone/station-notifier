import Foundation
import Combine
import CoreLocation

class LocationState {
    
    private (set) var location: CLLocation = CLLocation()
    private (set) var latitude: CLLocationDegrees   = CLLocationDegrees()
    private (set) var longitude: CLLocationDegrees  = CLLocationDegrees()
    private (set) var timeStamp: Date               = Date()
    private (set) var speed: CLLocationSpeed        = CLLocationSpeed()
    private (set) var course: CLLocationDirection   = CLLocationDirection()

    func add(location: CLLocation) {
        self.location   = location
        self.latitude   = location.coordinate.latitude
        self.longitude  = location.coordinate.longitude
        self.timeStamp  = location.timestamp
        self.speed      = location.speed
        self.course     = location.course
    }
}

extension LocationState: Decodable {
    private enum CodingKeys: String, CodingKey {
        case
        location,
        latitude,
        longitude,
        timeStamp,
        speed,
        course
    }

    required init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)

        guard let location = { try? container.decode(Data.self, forKey: .location) }()
            .flatMap({ data in try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? CLLocation }) else {

            throw DecodingError.typeMismatch(Data.self, DecodingError.Context(codingPath: [CodingKeys.location], debugDescription: "Failed to save location"))
        }

        guard let speed = { try? container.decode(Data.self, forKey: .speed) }()
           .flatMap({ data in try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? CLLocationSpeed }) else {

           throw DecodingError.typeMismatch(Data.self, DecodingError.Context(codingPath: [CodingKeys.speed], debugDescription: "Failed to save speed"))
       }

        guard let course = { try? container.decode(Data.self, forKey: .course) }()
              .flatMap({ data in try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? CLLocationDirection }) else {

              throw DecodingError.typeMismatch(Data.self, DecodingError.Context(codingPath: [CodingKeys.course], debugDescription: "Failed to save course"))
          }

        self.location = location
        self.course = course
        self.speed = speed
        self.timeStamp = try container.decode(Date.self, forKey: .timeStamp)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
    }
}

extension LocationState: Encodable {

}
