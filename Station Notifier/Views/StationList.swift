import SwiftUI
import MapKit

struct StationList : View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello World!"/*@END_MENU_TOKEN@*/)
    }


    // MARK: - Station Request
    func requestStations() -> MKMapItem {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "tri-rail"
        request.pointOfInterestFilter = MKPointOfInterestFilter.init(including: [.publicTransport])

        let search = MKLocalSearch(request: request)
        search.start(completionHandler: )

    }
}

#if DEBUG
struct StationList_Previews : PreviewProvider {
    static var previews: some View {
        StationList()
    }
}
#endif
