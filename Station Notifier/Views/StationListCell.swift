import SwiftUI
import MapKit
import Combine

struct StationListCell : View {
    var station: Station
    var tripPoint: TripPoint
    
    var body: some View {
        HStack {
            Text(station.name)
                .font(.system(size: 25))
                .fontWeight(.bold)
        }
    }
}

#if DEBUG
struct StationList_Previews : PreviewProvider {
    static var previews: some View {
        StationListCell(station: sampleStations.first!, tripPoint: .start(sampleStations.first!))
        StationListCell(station: sampleStations.first!, tripPoint: .intermediate(sampleStations.first!))
        StationListCell(station: sampleStations.first!, tripPoint: .end(<#T##Station#>)(sampleStations.first!))
    }
}
#endif
