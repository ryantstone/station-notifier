import Foundation
import Combine

class TransitFeedsAPI {
    let api = BaseAPI()
    func getData(_ feed: URL) -> AnyPublisher<Data, APIError> {
        return api.getData(feed)
    }
}

class BaseAPI {
    func getData(_ url: URL) -> AnyPublisher<Data, APIError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .mapError { APIError.apiError(reason: $0.localizedDescription) }
            .eraseToAnyPublisher()
    }
}

enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String)

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason):
            return reason
        }
    }
}
