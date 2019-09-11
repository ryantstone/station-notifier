import Foundation
import Combine
import MapKit

class StationState: Codable {
    private (set) var stationList = [Station]()
    private var gtfsServiceCancellable: AnyCancellable!
    private (set) var transitSystem: TransitSystem? 

    func set<T>(_ obj: T) {
        switch obj {
        case let stations as [Station]:
            self.stationList = stations
        case let transitSystem as TransitSystem:
            self.transitSystem = transitSystem
        case let url as URL:
            gtfsServiceCancellable = GTFSService(url: url).getTransitData().sink(receiveCompletion: { (error) in
                print(error)
            }) { [weak self] (system) in
                guard let self = self else { return }
                
                self.transitSystem = system
            }
        default:
            break
        }
    }
}
