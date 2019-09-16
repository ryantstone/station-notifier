import SwiftUI
import Combine
import SwiftUIFlux

struct TransitSystemPicker: View {
    
    @EnvironmentObject var viewModel: TransitSystemPickerViewModel

    var body: some View {
        NavigationView {
            List(viewModel.$locations) { location in
                HStack {
                    NavigationLink<Text, TransitFeedsPicker>(
                        location.title,
                        destination: TransitFeedsPicker()
                            .environmentObject(self.transitFeedsViewModel(locationID: location.id))
                    ).navigationBarTitle("Services")
                }
            }.navigationBarTitle("Locations")
        }.onAppear { self.store.dispatch(action: GetLocationsAction()) }
    }

    func transitFeedsViewModel(locationID: Int) -> TransitFeedsPickerViewModel {
        return TransitFeedsPickerViewModel(store: viewModel.store, locationId: locationID)
    }

    func dispatch(location: Location) {
        store.dispatch(action: GetFeedsAction(locationId: location.id))
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
