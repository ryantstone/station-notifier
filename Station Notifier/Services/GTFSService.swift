import Foundation
import Combine

class GTFSService: ObservableObject {
    private var cancellable: Cancellable!
    private let api = BaseAPI()
    private let url: URL
    private let feed: Feed
    var title: String { return feed.title }

    init(feed: Feed) {
        guard let feedUrl = feed.url?.feedURL,
            let url = URL(string: feedUrl) else { fatalError() }

        self.feed = feed
        self.url = url
    }
    
    func getTransitData() -> AnyPublisher<TransitSystem, Error> {
        return api.getData(url)
            .tryMap { try DocumentsDirectoryWriterService().write($0, name: self.title) }
            .tryMap { try UnzippingService.unzip(url: $0) }
            .tryMap { try FileManager().contentsOfDirectory(at: $0, includingPropertiesForKeys: nil, options: []) }
            .map { TransitSystem(urls: $0, feedId: self.feed.id) }
            .eraseToAnyPublisher()
    }
}
