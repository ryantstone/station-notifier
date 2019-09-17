import SwiftUI
import Combine
import SwiftUIFlux

struct TransitFeedsPicker: View {
    
    @EnvironmentObject var viewModel: TransitFeedsPickerViewModel

    var body: some View {
        List(viewModel.feeds) { feed in
            HStack {
                Text(feed.title).onTapGesture {
                    self.viewModel.didTapFeed(feed)
                }
            }
        }.onAppear { self.viewModel.start() }
         .navigationBarTitle("Feeds")
    }
}

struct TransitFeedsPicker_Previews: PreviewProvider {
    static var previews: some View {
        TransitSystemPicker()
    }
}
