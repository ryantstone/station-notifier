import Foundation
import UIKit

class AppDelegateService {

    let documentService: DocumentsDirectoryWriterService
    
    init(documentService: DocumentsDirectoryWriterService = DocumentsDirectoryWriterService()) {
        self.documentService = documentService
    }
    
    @discardableResult func saveState() -> Result<URL, Error> {
        return documentService.encodeAndWrite(store.state, name: "state")
    }
    
    func getState() -> AppState? {
        return try? documentService.getAndDecode(name: "state", type: AppState.self).get()
    }
}
