import SwiftUI
import Combine
import SwiftUIFlux

struct TransitFeedsPicker: View {
    
    @EnvironmentObject private var store: Store<AppState>
    var locationId: Int
    var location: Location? { store.state.transitSystemState.locations.first(where: { $0.id == locationId }) }
    var feeds: [Feed] { Array(location?.feeds ?? []) }
    
    var body: some View {
        List(feeds) { feed in
            HStack {
                Text(feed.title)
            }
        }.onAppear { self.getFeeds(for: self.location) }
         .navigationBarTitle("Feeds")
    }
    
    func getFeeds(for location: Location?) {
        guard let location = location else { return }
        
        self.store.dispatch(action: GetFeedsAction(location: location))
    }
}

struct TransitFeedsPicker_Previews: PreviewProvider {
    static var previews: some View {
        TransitSystemPicker()
    }
}
