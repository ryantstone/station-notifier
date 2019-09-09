import XCTest
@testable import Station_Notifier

class TripReducerTests: XCTestCase {
    
    var store: Store<AppState>!
    
    override func setUp() {
        store = Store(reducer: appStateReducer,
                      middleware: [],
                      state: AppState(),
                      queue: .main)
    }

    override func tearDown() {}

    func test_tripAction_startAndFinish() {
        store.state.tripState.start = StationMocks.deerfield
        
        store.dispatch(action: AddTripPoint(station: StationMocks.ftlAirport,
                                            tripPoint: .end,
                                            stationList: StationMocks.stations))
        
        let expectedStations = [
            StationMocks.pompano,
            StationMocks.cypressCreek,
            StationMocks.ftlBroward
        ]
        
        XCTAssertTrue(store.state.tripState.start == StationMocks.deerfield)
        XCTAssertTrue(store.state.tripState.end == StationMocks.ftlAirport)
        XCTAssertTrue(store.state.tripState.intermediateStations == expectedStations)
    }
}
