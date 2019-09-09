import Foundation
import CoreLocation

extension CLLocation {
    func degreesToRadians(degrees: Double) -> Double {
        return degrees * Double.pi / 180
    }

    func distanceInKmBetweenEarthCoordinates(lat2: Double, lon2: Double) -> Double {

        let earthRadiusMeters: Double = 6_371_000

        let dLat = degreesToRadians(degrees: lat2 - self.coordinate.latitude)
        let dLon = degreesToRadians(degrees: lon2 - self.coordinate.longitude)

        let lat1 = degreesToRadians(degrees: self.coordinate.latitude)
        let lat2 = degreesToRadians(degrees: lat2)

        let a = sin(dLat/2) * sin(dLat/2) + sin(dLon/2) * sin(dLon/2) * cos(lat1) * cos(lat2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        return earthRadiusMeters * c
    }
}

