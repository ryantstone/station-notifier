import Foundation
import MapKit
import Combine
import SwiftUIFlux

// MARK: -  Sync Actions
struct AddStationsAction: Action {
    let stations: [Station]
}

struct AddTransitSystem: Action {
    let transitSystem: TransitSystem
}

struct ReceiveGTFSURL: Action {
    let url: URL
}

// MARK: - Async Actions
struct FetchStationAction: AsyncAction {
    func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = "tri-rail"
//        request.pointOfInterestFilter = MKPointOfInterestFilter.init(including: [.publicTransport])
//
//        let search = MKLocalSearch(request: request)
//        search.start() { (response, error) in
//            guard let response = response else {
//                if let error = error {
//                    print(error)
//                }
//                return
//            }
//            let stations = response.mapItems.compactMap(Station.init)
//            dispatch(AddStationsAction(stations: stations))
//        }
        
        let url = URL(string: "http://www.tri-rail.com/GTDF/Current/google_transit.zip")!
        let action = ReceiveGTFSURL(url: url)
        
        store.dispatch(action: action)
    }
}
