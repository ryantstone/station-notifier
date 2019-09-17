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
                        destination: TransitFeedsPicker()
                            .environmentObject(
                                TransitFeedsPickerViewModel(
                                    store: self.viewModel.store,
                                    locationId: location.id
                            )
                        )
                    )
                }
            }
        }.navigationBarTitle("Systems")
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
