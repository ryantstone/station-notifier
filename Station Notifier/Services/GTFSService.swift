import Foundation
import Combine

class GTFSService: ObservableObject {
    private var cancellable: Cancellable!
    private let api = TransitFeedsAPI()
    private let url: URL

    init(url: URL) {
        self.url = url
    }
    
    func getTransitData() -> AnyPublisher<TransitSystem, Error> {
        return api.getData(url)
            .tryMap { try DocumentsDirectoryWriterService.write($0, name: "tri-rail") }
            .tryMap { try UnzippingService.unzip(url: $0) }
            .tryMap { try FileManager().contentsOfDirectory(at: $0, includingPropertiesForKeys: nil, options: []) }
            .map { TransitSystem(urls: $0) }
            .eraseToAnyPublisher()
    }
}
