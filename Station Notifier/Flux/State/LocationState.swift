import Foundation
import Combine
import CoreLocation

class LocationState {
    lazy var locationService = LocationManager.shared.currentLocation
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

    private (set) var latitude: CLLocationDegrees   = CLLocationDegrees()
    private (set) var longitude: CLLocationDegrees  = CLLocationDegrees()
    private (set) var timeStamp: Date               = Date()
    private (set) var speed: CLLocationSpeed        = CLLocationSpeed()
    private (set) var course: CLLocationDirection   = CLLocationDirection()
    
    init() {
        _ = locationService
    }
}
