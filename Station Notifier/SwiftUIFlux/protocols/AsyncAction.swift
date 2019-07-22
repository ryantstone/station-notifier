import Foundation
import Combine

public protocol AsyncAction: Action {
    func execute(state: FluxState?, dispatch: @escaping DispatchFunction)
}




