import Foundation
import SwiftUIFlux
import Combine

class TransitSystemPickerViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    @Published var store: Store<AppState>
    @Published var locations = [Location]()

    init(store: Store<AppState>) {
        self.store = store

        setupSubscribers()
    }

    func setupSubscribers() {
        _ = store.$state
            .map({ state in state.transitSystemState.locations })
            .map({ locations in
                return locations.sorted(by: { $0.title < $1.title })
            })
            .assign(to: \.locations, on: self)

    }
}
