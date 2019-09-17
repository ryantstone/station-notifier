import XCTest
@testable import Station_Notifier

class UserDefaultStorageTests: XCTestCase {

    var storage: UserDefaultStorage!
    
    override func setUp() {
        storage = UserDefaultStorage()
    }
    override func tearDown() { }

    func test_set() {
        let data: Int = 1
        let key = "One"
        
        let result = storage.set(data, key: key)
        
        XCTAssertTrue(result)
        
        let retrievedData = UserDefaults.standard.object(forKey: key) as! Data
        let retrievedNumber = try? JSONDecoder().decode(Int.self, from: retrievedData)
        
        XCTAssertEqual(retrievedNumber, 1)
    }
    
    func test_get() {
        let encodedData = try? JSONEncoder().encode(1)
        let key = "data"
        
        UserDefaults.standard.set(encodedData, forKey: key)
        
        let result = storage.get(Int.self, key: key)
        
        XCTAssertEqual(1, result)
    }
}
