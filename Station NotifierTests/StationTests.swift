import XCTest
import CoreLocation
import MapKit
@testable import Station_Notifier

class StationTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func test_initializers() {
        let lat = CLLocationDegrees(exactly: 40.6892)!
        let long = CLLocationDegrees(exactly: 74.0445)!
        let coord = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let placemark = MKPlacemark(coordinate: coord)
        let mapItem = MKMapItem(placemark: placemark)

        let init1 = Station(mapItem)
        let init2 = Station(name: "Unknown Location", latitude: lat, longitude: long, location: nil)

        XCTAssertEqual(init1, init2)
    }

    func test_codable() {
        let lat = CLLocationDegrees(exactly: 40.6892)!
        let long = CLLocationDegrees(exactly: 74.0445)!
        let coord = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let placemark = MKPlacemark(coordinate: coord)
        let mapItem = MKMapItem(placemark: placemark)
        
        let expectedResult = Station(mapItem)!
        let key = "station"
        
        let storage = UserDefaultStorage()
        
        storage.set(expectedResult, key: key)
        
        let result = storage.get(Station.self, key: key)
        
        XCTAssertEqual(result, expectedResult)
    }
}
