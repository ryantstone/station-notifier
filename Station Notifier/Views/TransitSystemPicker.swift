import SwiftUI
import Combine
import SwiftUIFlux

struct TransitSystemPicker: View {
    
    @EnvironmentObject var viewModel: TransitSystemPickerViewModel

    var body: some View {
        NavigationView {
            List(viewModel.locations) { (location) in
                HStack {
                    NavigationLink(
                        location.name,
                        destination: TransitFeedsPicker().environmentObject(TransitFeedsPickerViewModel(locationId: location.id))
                    )
                }
            }
        }.navigationBarTitle("Systems")
        .onAppear { store.dispatch(action: GetLocationsAction()) }
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
