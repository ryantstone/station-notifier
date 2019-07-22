import SwiftUI

struct StationPickerView: View {
    
    @EnvironmentObject private var store: Store<AppState>
    @State var startStation: Station?
    @State var endStation: Station?
    var stationList: [Station]
    var trip: Trip
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                TitledView(title: "Start", subTitle: "Select Station", tapAction: {})
                TitledView(title: "End", subTitle: "Select Station", tapAction: {})
            }
            List(stationList) { station in
                StationListCell(station: station, tripPoint: .start(station))
            }
        }
    }
    
    // MARK: - Functions
    private func didTap(tripPoint: TripPoint) {
        
    }
}

enum TripPoint {
    case
        start(Station),
        intermediate(Station),
        end(Station)
}

#if DEBUG
struct StationPickerViewPreviews: PreviewProvider {
    static var previews: some View {
        StationPickerView(startStation: nil,
                          endStation: nil,
                          stationList: sampleStations,
                          trip: Trip()).environmentObject(sampleStore)
    }
}

let sampleStations = [
    Station(name: "Deerfield Beach Station", latitude: 26.454215, longitude:  -80.090934)
]

#endif


