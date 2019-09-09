import Foundation
import Combine

class API {
    static let shared = API()

    let transitFeedsAPI = TransitFeedsAPI(baseAPI: BaseAPI())
}

class TransitFeedsAPI {
    let api: BaseAPI
    let baseUrl = "https://api.transitfeeds.com/v1"
    var cancellables = Set<AnyCancellable>()

    enum Path: String {
        case getLocations = "/getLocations",
        getFeeds = "/getFeeds"
    }
    
    init(baseAPI: BaseAPI = BaseAPI()) {
        self.api = baseAPI
    }

    // MARK: - Get Feeds
    func getFeeds(location: Location) {
        let item = URLQueryItem(name: "location", value: String(describing: location.id))
        guard let url = buildURLComponents(path: .getFeeds, queryItems: [item]) else { return }
        
        makeRequest(TransitFeedsResponse<GetFeedsResults>.self, url: url)
            .sink(receiveCompletion: { (error) in
                print(error)
            }, receiveValue: { results in
                results.results?.feeds.flatMap { feeds in
                    store.dispatch(action: SetFeedsAction(location: location, feeds: feeds))
                }
            }).store(in: &cancellables)
    }

    // MARK: - Get Locations
    func getLocations() {
        guard let url = buildURLComponents(path: .getLocations) else { return }
       
        makeRequest(TransitFeedsResponse<GetLocationsResults>.self, url: url)
            .sink(receiveCompletion: { (error) in print(error) },
                  receiveValue: { (locationsResponse) in
                    guard let locations = locationsResponse.results?.locations else { return }
                    store.dispatch(action: SetLocationsAction(locations: locations))
            })
            .store(in: &cancellables)
    }
    
    // MARK: - Private Functions
    private func makeRequest<T: Codable>(_ type: T.Type, url: URL) -> AnyPublisher<T, APIError> {
        return api.getData(url)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { APIError.apiError(reason: $0.localizedDescription) }
            .eraseToAnyPublisher()
    }
    
    private func buildURLComponents(path: Path, queryItems: [URLQueryItem] = []) -> URL? {
        return URL(string: baseUrl + path.rawValue)
            .flatMap({ URLComponents(url: $0, resolvingAgainstBaseURL: false)})
            .flatMap({ url -> URLComponents in
                var url = url
                url.queryItems = [ URLQueryItem(name: "key", value: Constants.transitFeedsKey) ]
                url.queryItems?.append(contentsOf: queryItems)
                return url
            }).flatMap({ $0.url })
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

