import SwiftUI
import Combine
import SwiftUIFlux

struct TransitSystemPicker: View {
    
    @EnvironmentObject private var store: Store<AppState>
    var locations: [Location] { return Array(store.state.transitSystemState.locations) }
    
    var body: some View {
        NavigationView {
            List(locations) { location in
                HStack {
                    NavigationLink(
                        location.title,
                        destination: TransitFeedsPicker(locationId: location.id)
                            .environmentObject(TransitFeedsPickerViewModel(store: store, locationId: location.id))
                    ).navigationBarTitle("Services")
                }
            }.navigationBarTitle("Locations")
        }.onAppear { self.store.dispatch(action: GetLocationsAction()) }
    }
    
    func wrappedLocations() -> [IdentifiableWrapper<Location>] {
        return locations
            .sorted { $0.title < $1.title }
            .map { IdentifiableWrapper(wrapped: $0)}
    }
    
    func dispatch(location: Location) {
        store.dispatch(action: GetFeedsAction(location: location))
    }
}

struct TransitSystemPicker_Previews: PreviewProvider {
    static var previews: some View {
        TransitSystemPicker()
    }
}

struct IdentifiableWrapper<T>: Identifiable {
    var id: UUID = UUID()
    
    var wrapped: T
}
