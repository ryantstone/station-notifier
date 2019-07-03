import SwiftUI
import Combine
import CoreLocation

class AppState: BindableObject {
    var didChange = PassthroughSubject<Void, Never>()
    let locationManager = LocationManager()
    var currentLocation: PassthroughSubject<CLLocation, Error> { locationManager.currentLocation
    }
    var location: CLLocation {
        locationManager.location
    }
}
