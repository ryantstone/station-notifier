import SwiftUI
import Combine
import SwiftUIFlux

struct TransitFeedsPicker: View {
    
    @EnvironmentObject var viewModel: TransitFeedsPickerViewModel

    var body: some View {
        List(viewModel.feeds) { feed in
            HStack {
                Text(feed.title)
            }
        }.onAppear { self.viewModel.start() }
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
