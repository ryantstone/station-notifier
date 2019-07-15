import SwiftUI
import Combine
import CoreLocation

struct ContentView : View {
    
    @ObjectBinding var appState: AppState
    
    var body: some View {
        HStack {
            Text("\(appState.locationState.latitude)")
        }
    }
}

#if DEBUG
//struct ContentView_Previews : PreviewProvider {
//    static var previews: some View {
////        ContentView(state: AppState())
//    }
//}
#endif
