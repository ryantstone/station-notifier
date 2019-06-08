import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject {

    static let shared = LocationManager()

    let manager = CLLocationManager()
    let currentLocation = Publisher<CLLocation>()

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
                manager.requestLocation()
            case .restricted, .denied:
                // FIXME: Add some sort of pop up notifying that the app won' t work
                print("Location restricted/denied")
            @unknown default:
               fatalError("Unkown new state")
            }
        }
    }
}

// MARK: - Location Manager Delegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

    }
}

struct CurrentLocation: Publisher {
    public typealias Failure = Error
    public typealias Output =  CLLocation

    public func receive<S>(on scheduler: S, options: S.SchedulerOptions? = nil) -> Publishers.ReceiveOn<CurrentLocation, S> where S : Scheduler {
        <#code#>
    }
}
