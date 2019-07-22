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


