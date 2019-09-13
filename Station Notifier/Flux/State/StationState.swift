import Foundation
import Combine
import MapKit

class StationState: Codable {
    private (set) var stationList = [Station]()
    private (set) var transitSystem: TransitSystem?

    func set<T>(_ obj: T) {
        switch obj {
        case let stations as [Station]:
            self.stationList = stations
        case let transitSystem as TransitSystem:
            self.transitSystem = transitSystem
        default:
            break
        }
    }
}
