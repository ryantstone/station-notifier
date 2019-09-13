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
        registerSubscribers()
    }
    
    func registerSubscribers() {
        _ = store.$state
            .assertNoFailure()
            .map({ $0.transitSystemState.locations })
            .map({ locations in locations.first(where: { location in location.id == self.locationId })!.feeds })
            .sink(receiveValue: { self.feeds = $0 })
            .store(in: &cancellables)
            
    }
}
