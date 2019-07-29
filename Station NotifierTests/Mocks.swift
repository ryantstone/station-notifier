import Foundation
@testable import Station_Notifier

struct StationMocks {
    
    static let stations: [Station] = [
        StationMocks.deerfield,
        StationMocks.pompano,
        StationMocks.cypressCreek,
        StationMocks.ftlBroward,
        StationMocks.ftlAirport
    ]
    
    static let deerfield = Station(name: "Deerfield Beach Station",
                                   latitude:  26.31694,
                                   longitude: -80.12222)
    
    static let pompano = Station(name: "Pompano Beach Station",
                                 latitude: 26.272286,
                                 longitude: -80.134814)
    
    static let cypressCreek = Station(name: "Cypress Creek Station",
                                      latitude: 26.201194,
                                      longitude: -80.150369)
    
    static let ftlBroward = Station(name: "Fort Lauderdale Broward Station",
                                    latitude: 26.119942,
                                    longitude: -80.169808)
    
    static let ftlAirport = Station(name: "Fort Lauderdale Airport",
                                    latitude: 26.061653,
                                    longitude: -80.165683)
}
