import SwiftUI
import MapKit
import Combine

struct StationListCell : View {
    var station: Station
    var tripPoint: TripPoint?
    
    var body: some View {
        HStack {
//            tripPointViewBuilder()
//            Spacer()
            Text(station.name)
                .font(.system(size: 25))
                .fontWeight(.bold)
        }
    }
    
    
    func tripPointViewBuilder() -> AnyView {
        switch tripPoint {
        case .start:
            return AnyView(
                VStack {
                    Circle().padding(EdgeInsets(top: 25, leading: 15, bottom: 25, trailing: 15))
                    Path {
                        $0.move(to: CGPoint(x: 0, y: 0))
                        $0.move(to: CGPoint(x: 0, y: 0))
                    }.fill()
                        .background(SwiftUI.Color.black)
                        .frame(width: 7, alignment: .center)
                }
            )
        case .intermediate:
            return AnyView (
                HStack {
                    Spacer(minLength: 20)
                    Path { path in
                        path.move(to: CGPoint(x: 1, y: 0))
                        path.move(to: CGPoint(x: 1, y: 15))
                        path.move(to: CGPoint(x: 0, y: 15))
                    }.fill()
                     .background(SwiftUI.Color.black)
                    .frame(width: 7, alignment: .center)
                    Spacer(minLength: 10)
                }
            )
        case .end:
            return AnyView (
                    Path { path in
                        let width: CGFloat = 10
                        let height: CGFloat = 30
                        
                        path.move(to: CGPoint(x: width, y: 0))
                        path.move(to: CGPoint(x: width, y: height))
                        path.move(to: CGPoint(x: 0, y: 0))
                    }.fill(Color.black)
//                    Circle().padding(EdgeInsets(top: 25, leading: 15, bottom: 25, trailing: 15))
            )
        default:
            fatalError()
        }
    }
}

#if DEBUG
struct StationList_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            StationListCell(station: sampleStations.first!, tripPoint: .start)
            StationListCell(station: sampleStations.first!, tripPoint: .intermediate)
            StationListCell(station: sampleStations.first!, tripPoint: .end)
        }.previewLayout(.fixed(width: 400, height: 70))
    }
}
#endif
