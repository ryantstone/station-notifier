import Foundation

enum DocumentsDirectoryServiceError: Error {
    case failedToReadData,
        failedToDecodeData(String)
}

class DocumentsDirectoryWriterService {
   
    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    private let fileManager: FileManager
    
    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }
    
    func getAndDecode<T: Codable>(name: String, type: T.Type) -> Result<T, DocumentsDirectoryServiceError> {
        guard let data = read(name: name) else {
            return .failure(.failedToReadData)
        }
        
        return Result { try JSONDecoder().decode(T.self, from: data) }
            .flatMapError { .failure(DocumentsDirectoryServiceError.failedToDecodeData($0.localizedDescription)) }
    }
    
    func encodeAndWrite<T: Codable>(_ data: T, name: String) -> Result<URL, Error> {
        return Result {
            let data = try JSONEncoder().encode(data)
            return try write(data, name: name)
        }
    }
    
    func read(name: String) -> Data? {
        return fileManager.contents(atPath: url(of: name).path)
    }
    
    func write(_ data: Data, name: String) throws -> URL {
        let destination = url(of: name)
        try data.write(to: destination)
        return destination
    }
    
    func url(of name: String) -> URL {
        documentsDirectory.appendingPathComponent(name)
    }
}
