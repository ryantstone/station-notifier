import Foundation
import Combine
import CoreLocation

struct LocationState {
    let locationService: LocationManager = LocationManager.shared

    private (set) var latitude: CLLocationDegrees   = CLLocationDegrees()
    private (set) var longitude: CLLocationDegrees  = CLLocationDegrees()
    private (set) var timeStamp: Date               = Date()
    private (set) var speed: CLLocationSpeed       = CLLocationSpeed()
    private (set) var course: CLLocationDirection  = CLLocationDirection()

    private lazy var currentLocationSubscriber = locationService.currentLocation
        .debounce(for: 0.5, scheduler: RunLoop.main)
        .removeDuplicates()
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { (error) in
            print(error)
        }) { (location) in
            self.latitude    = location.coordinate.latitude
            self.longitude   = location.coordinate.longitude
            self.timeStamp   = location.timestamp
            self.speed       = location.speed
            self.course      = location.course
        }
}
