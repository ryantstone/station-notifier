import SwiftUI
import Combine
import SwiftUIFlux

struct TransitFeedsPicker: View {
    
    @EnvironmentObject private var viewModel: TransitFeedsPickerViewModel

    init(viewModel: TransitFeedsPickerViewModel) {
        _ = self.environmentObject(viewModel)
//        self._viewModel =
//        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.feeds) { feed in
            HStack {
                Text(feed.title)
            }
        }.onAppear { self.getFeeds(for: self.viewModel.locationId) }
         .navigationBarTitle("Feeds")
    }
    
    func getFeeds(for locationId: Int) {
        self.viewModel.store.dispatch(action: GetFeedsAction(locationId: locationId))
    }
}

struct TransitFeedsPicker_Previews: PreviewProvider {
    static var previews: some View {
        TransitSystemPicker()
    }
}
