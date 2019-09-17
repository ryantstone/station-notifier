import Foundation
import CoreLocation

extension CLLocation {
    func degreesToRadians(degrees: Double) -> Double {
        return degrees * Double.pi / 180
    }
}


extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude
    }
}
