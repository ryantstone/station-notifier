import SwiftUI
import MapKit
import Combine

struct StationListCell : View {
    var station: Station
    var tripPoint: TripPoint?
    
    var body: some View {
        HStack {
            tripPointViewBuilder()
            Text(station.name)
                .font(.system(size: 25))
                .fontWeight(.bold)
        }
    }
    
    
    func tripPointViewBuilder() -> some View {
        switch tripPoint {
        case .start:
            return Circle()
                .padding(EdgeInsets(top: 25, leading: 15, bottom: 25, trailing: 15))
        case .intermediate:
            return Path { path in
                path.move(to: CGPoint(x: 5, y: 0))
                path.move(to: CGPoint(x: 5, y: 10))
            }
        case .end:
            return Circle()
        }
    }
}

#if DEBUG
struct StationList_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            StationListCell(station: sampleStations.first!, tripPoint: .start(sampleStations.first!))
            StationListCell(station: sampleStations.first!, tripPoint: .intermediate(sampleStations.first!))
            StationListCell(station: sampleStations.first!, tripPoint: .end(sampleStations.first!))
        }.previewLayout(.fixed(width: 400, height: 70))
    }
}
#endif
