import SwiftUI
import Combine

//
//class ContentViewModel: BindableObject {
//    var didChange = PassthroughSubject<Void, Never>()
//    let appState: AppState
//    var locationText: String = "No Location" {
//        didSet { didChange.send(Void()) }
//    }
//    
//    init(state: AppState) {
//        self.appState = state
//    }
//    
//    private func bind() {
//        appState.currentLocation
//            .removeDuplicates()
//            .map({ return "\($0.coordinate.longitude), \($0.coordinate.latitude)" })
//            .replaceError(with: "Location Unavailable")
//            .eraseToAnyPublisher()
//            .assign(to: \.locationText, on: self)
//    }
//}


