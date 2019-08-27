import Foundation
import Combine

class TransitFeedsAPI {
    let api = BaseAPI()
    let baseUrl = "https://transitfeeds.com/issues"
    
    func getLocations() -> AnyPublisher<Locations, APIError> {
        guard let url = URL(string: baseUrl + "/getLocations") else {
            return AnyPublisher<Locations, APIError>
        }
        
        return api.getData(feed)
            .decode(type: Locations.self, decoder: JSONDecoder())
            .mapError { APIError.apiError(reason: $0.localizedDescription) }
            .eraseToAnyPublisher()
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

struct Locations: Codable {
    let status: String
    let ts: String
    let results: Results
    
    struct Results: Codable {
        let locations: [Location]
    }
}

struct Location: Codable {
    let id: String
    let pid: Int
    let title: String
    let name: String
    let lattitude: Double
    let longitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case id,
        pid,
        title = "t",
        name = "n",
        lattitude = "lat",
        longitude = "lon"
    }
}
