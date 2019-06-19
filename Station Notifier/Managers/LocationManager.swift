import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject {
    static let shared = LocationManager()

    let manager = CLLocationManager()
    @Published var currentLocation = PassthroughSubject<CLLocation, Error>()

    typealias locationManagerCompletion = (CLLocation) -> ()

    override init() {
        super.init()
        manager.delegate = self
        manager.distanceFilter = kCLDistanceFilterNone
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        getCurrentLocation()
    }

    func getCurrentLocation() {
        if  CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                manager.requestLocation()
            case .restricted:
                currentLocation.send(completion: .failure(LocationError.restricted))
            case .denied:
                currentLocation.send(completion: .failure(LocationError.denied))
                // FIXME: Add some sort of pop up notifying that the app won' t work
                print("Location restricted/denied")
            @unknown default:
               fatalError("Unkown new state")
            }
        }
    }
}

enum LocationError: Error {
    case restricted, denied
}

// MARK: - Location Manager Delegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation.send(location)
    }
}
