import SwiftUI
import Combine
import CoreLocation
import SwiftUIFlux

struct ContentView : View {
    
    @EnvironmentObject var store: Store<AppState>
    let wrapper = SearchWrapper()
    
    var body: some View {
        VStack {
            SearchField(searchWrapper: wrapper, placeHolder: "Search")
            Text(store.state.locationState.latitude.description)
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {

    static var previews: some View {
        ContentView().environmentObject(store)
    }
}
#endif
