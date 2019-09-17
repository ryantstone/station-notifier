import XCTest
import MapKit
@testable import Station_Notifier

class LocationStateTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func test_codable() throws {
        let lat = CLLocationDegrees(exactly: 40.6892)!
        let long = CLLocationDegrees(exactly: 74.0445)!
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let distance = CLLocationDistance(exactly: 20)
        let accuracy = CLLocationAccuracy(30)
        let direction = CLLocationDirection(exactly: 120)
        let speed = CLLocationSpeed(exactly: 99)
        let date = Date()
        
        
        let location = CLLocation(coordinate: coordinates,
                                  altitude: distance!,
                                  horizontalAccuracy: accuracy,
                                  verticalAccuracy: accuracy,
                                  course: direction!,
                                  speed: speed!,
                                  timestamp: date)
        

        var locationState = LocationState()
        locationState.add(location: location)
        
        let encodedData = try JSONEncoder().encode(locationState)
        let decodedData = try JSONDecoder().decode(LocationState.self, from: encodedData)

        XCTAssertEqual(locationState.location.timestamp, decodedData.location.timestamp)
        XCTAssertEqual(locationState.location.horizontalAccuracy, decodedData.location.horizontalAccuracy)
        XCTAssertEqual(locationState.location.verticalAccuracy, decodedData.location.verticalAccuracy)
        XCTAssertEqual(locationState.location.altitude, decodedData.location.altitude)
        XCTAssertEqual(locationState.location.speed, decodedData.location.speed)
    }
}
