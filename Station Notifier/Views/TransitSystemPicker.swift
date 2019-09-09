import SwiftUI
import Combine
import SwiftUIFlux

struct TransitSystemPicker: View {
    
    @EnvironmentObject private var store: Store<AppState>
    var locations: [Location] { return Array(store.state.transitSystemState.locations) }
    
    var body: some View {
        List(wrappedLocations()) { location in
            HStack {
                Text(location.wrapped.name)
                    .onTapGesture { self.dispatch(location: location.wrapped) }
            }
        }.onAppear {
            self.store.dispatch(action: GetLocationsAction())
        }.navigationBarTitle("Locations")
    }
    
    func wrappedLocations() -> [IdentifiableWrapper<Location>] {
        return locations.map { IdentifiableWrapper(wrapped: $0)}
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
