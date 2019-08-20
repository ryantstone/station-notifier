import SwiftUI
import Combine
import CoreLocation
import SwiftUIFlux

struct ContentView : View {
    
    @EnvironmentObject var store: Store<AppState>
    var stations: [Station] {
        store.state.stationState.stationList
    }
    let wrapper = SearchWrapper()
    
    var body: some View {
        StationPickerView(stationList: stations)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(store)
    }
}
#endif
