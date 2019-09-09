import Foundation

class DocumentsDirectoryWriterService {
   
    private let data: Data
    private let name: String
    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    static func write(_ data: Data, name: String) throws -> URL {
        return try DocumentsDirectoryWriterService(data, name).perform()
    }
    
    private init(_ data: Data, _ name: String) {
        self.data = data
        self.name = name
    }
    
    private func perform() throws -> URL {
        let destinationURL = documentsDirectory.appendingPathComponent(name)
        _ = try data.write(to: destinationURL)
        return destinationURL
    }
}
