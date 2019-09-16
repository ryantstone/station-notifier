import SwiftUI
import Combine
import SwiftUIFlux

struct TransitSystemPicker: View {
    
    @EnvironmentObject var viewModel: TransitSystemPickerViewModel

    var body: some View {
        NavigationView {
            List(viewModel.$locations) { location in
                HStack {
                    NavigationLink(destination: destinationViewModel(locationId: location.id)) {
                        Text("TEST")
                    }
//                    NavigationLink<Text, TransitFeedsPicker>(destination: destinationViewModel(locationId: location.id)) {
//                        Text("TEST")
//                    }.navigationBarTitle("Services")
                }
            }.navigationBarTitle("Locations")
        }.onAppear { self.store.dispatch(action: GetLocationsAction()) }
    }
    
    func destinationViewModel(locationId: Int) -> TransitFeedsPicker {
        let vm = TransitFeedsPickerViewModel(locationId: locationId)
        return TransitFeedsPicker(viewModel: vm)
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
