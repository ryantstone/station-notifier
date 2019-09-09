import Foundation

// MARK: - Response
struct TransitFeedsResponse<T: Codable>: Codable {
    let status: String?
    let ts: Int?
    let msg: String?
    let results: T?
}

// MARK: - Get Locations Request
struct GetLocationsResults: Codable {
    let locations: [Location]
}

// MARK: - Location
struct Location: Codable, Equatable, Hashable, Identifiable {
    let id: Int
    let pid: Int
    let title: String
    let name: String
    let lattitude: Double
    let longitude: Double
    var feeds = Set<Feed>()
    
    private enum CodingKeys: String, CodingKey {
        case id,
        pid,
        title = "t",
        name = "n",
        lattitude = "lat",
        longitude = "lng"
    }
    
    mutating func add(feeds: [Feed]) {
        self.feeds.append(contentsOf: feeds)
    }
}

// MARK: - Get Feeds Request
struct GetFeedsResults: Codable {
    let input: String?
    let total, limit, page, numPages: Int?
    let feeds: [Feed]?
}

struct Feed: Codable, Equatable, Hashable, Identifiable {
    enum FeedType: String, Codable {
        case gtfsStatic = "gtfs"
        case realtime = "gtfsrealtime"
    }

    let id: String
    let type: String?
    let title: String
    let location: Location
    let url: URLWrapper?
    let latest: TimeStamp

    private enum CodingKeys: String, CodingKey {
        case
        id,
        type        = "ty",
        title       = "t",
        location    = "l",
        url         = "u",
        latest      = "latest"
    }

    struct URLWrapper: Codable, Equatable, Hashable {
        let feedInformation: String?
        let feedURL: String?

        private enum CodingKeys: String, CodingKey {
            case
            feedInformation = "i",
            feedURL         = "d"
        }
    }

    struct TimeStamp: Codable, Equatable, Hashable {
        let stamp: Int?

        private enum CodingKeys: String, CodingKey {
            case stamp = "ts"
        }
    }
}
