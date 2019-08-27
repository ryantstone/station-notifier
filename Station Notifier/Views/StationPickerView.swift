import SwiftUI
import SwiftUIFlux

struct StationPickerView: View {
    
    @EnvironmentObject private var store: Store<AppState>
    var stationList: [Station]
    @State var currentStationChoice = TripPoint.start
    var startButtonText = ""

    var body: some View {
        VStack {
            HStack(spacing: 40) {
                TitledView(title: "Start",
                           subTitle:  startButtonText,
                           action: { self.didChange(tripPoint: .start) })
                TitledView(title: "End",
                           subTitle: "Select Station",
                           action: { self.didChange(tripPoint: .end) })
            }.frame(width: UIScreen.main.bounds.width)
            List(stationList) { station in
                StationListCell(station: station, tripPoint: nil)
                    .onTapGesture { self.didSelect(station: station) }
            }
        }.onAppear(perform: {
            self.store.dispatch(action: FetchStationAction())
        })
    }
    
    // MARK: - Functions
    private func didChange(tripPoint: TripPoint) {
        self.currentStationChoice = tripPoint
    }
    
    private func didSelect(station: Station) {
//        startButtonText = station.name
        store.dispatch(action: AddTripPoint(station: station,
                                            tripPoint: currentStationChoice,
                                            stationList: stationList))
    }
}

enum TripPoint {
    case
        start,
        intermediate,
        end
}

#if DEBUG
struct StationPickerViewPreviews: PreviewProvider {
    static var previews: some View {
        StationPickerView(stationList: sampleStations).environmentObject(sampleStore)
    }
}

let sampleStations = [
    Station(name: "Deerfield Beach Station", latitude: 26.454215, longitude:  -80.090934)
]

#endif


