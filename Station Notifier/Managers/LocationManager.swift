import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject {

    static let shared = LocationManager()

    let manager = CLLocationManager()
    var currentLocation = PassthroughSubject<CLLocation, Error>()
    typealias locationManagerCompletion = (CLLocation) -> ()

    override init() {
        super.init()
        manager.delegate = self
        manager.distanceFilter = kCLDistanceFilterNone
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }

    func getCurrentLocation(completion: locationManagerCompletion) {
        if  CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                manager.startUpdatingLocation()
            case .restricted, .denied:
                currentLocation.send(completion: Subscribers.Completion<Error>.failure(LocationError.permissionDenied))
                print("Location restricted/denied")
            @unknown default:
               fatalError("Unkown new state")
            }
        }
    }
}

enum LocationError: Error {
    case permissionDenied
}

// MARK: - Location Manager Delegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.currentLocation.send(location)
    }
}
