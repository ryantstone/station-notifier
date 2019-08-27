import Foundation
import SwiftUIFlux

struct TransitSystemState {
    var locations: [Location]
}

struct GetLocationsAction: AsyncAction {
    var locations: [Location] = []
    let api = TransitFeedsAPI()
    
    func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
        api.getData(x)
    }
}
