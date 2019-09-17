import Foundation
import SwiftUIFlux
import Combine

class TransitFeedsPickerViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    
    @Published var feeds = [Feed]()
    @Published var store: Store<AppState>
    let locationId: Int

    init(store: Store<AppState>, locationId: Int) {
        self.store = store
        self.locationId = locationId
    }
    
    func start() {
        registerSubscribers()
        makeAPICalls()
    }
    
    func registerSubscribers() {
        store.$state
            .map({ $0.transitSystemState.locations })
            .map({ locations in
                locations.first(where: { location in location.id == self.locationId })!.feeds
                
            })
            .assign(to: \.feeds, on: self)
            .store(in: &cancellables)
    }
    
    func makeAPICalls() {
        API.shared.transitFeedsAPI.getFeeds(locationId: locationId)
    }
    
    func didTapFeed(_ feed: Feed) {
        API.shared.transitFeedsAPI.getGTFS(feed: feed)
    }
}
