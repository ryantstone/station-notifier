import Foundation
import Combine

// MARK: - API
class API {
    static let shared = API()
    
    let transitFeedsAPI = TransitFeedsAPI(baseAPI: BaseAPI())
}

// MARK: - BaseAPI
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

// MARK: -  API Error
enum APIError: Error, LocalizedError {
    case unknown,
    invalidUrl(String),
    apiError(reason: String)
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .invalidUrl(let url):
            return "Invalid URL: \(url)"
        case .apiError(let reason):
            return reason
        }
    }
}

