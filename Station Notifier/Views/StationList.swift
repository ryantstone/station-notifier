import SwiftUI
import MapKit
import Combine

struct StationList : View {
    var stations = [MKMapItem]()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello World!"/*@END_MENU_TOKEN@*/)
    }


    // MARK: - Station Request
    func requestStations() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "tri-rail"
        request.pointOfInterestFilter = MKPointOfInterestFilter.init(including: [.publicTransport])

        let search = MKLocalSearch(request: request)
        Future
        search.start() { (response, error) in
            guard
                error == nil,
                let response = response else {

                print(error!)
                return
            }

            self.stations.append(contentsOf: response.mapItems)
        }
    }
}

#if DEBUG
struct StationList_Previews : PreviewProvider {
    static var previews: some View {
        StationList()
    }
}
#endif
