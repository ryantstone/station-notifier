import Foundation
import CoreLocation
import Combine
import MapKit
import SwiftUIFlux

class LocationManager: NSObject {

    let manager = CLLocationManager()
    var store: Store<AppState>

    init(store: Store<AppState>) {
        manager.distanceFilter = kCLDistanceFilterNone
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.store = store

        super.init()

        manager.delegate = self
        getCurrentLocation()
    }


    func getCurrentLocation() {
        if  CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                manager.startUpdatingLocation()
            case .restricted, .denied:
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

        store.dispatch(action: AddLocationAction(location: location))
    }
}

struct AddLocationAction: Action {
    let location: CLLocation
}
