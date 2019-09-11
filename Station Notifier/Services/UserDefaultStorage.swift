import Foundation

class UserDefaultStorage: Persistable {
    
    func set<T: Codable>(_ object: T, key: String) -> Bool {
        if let data = try? JSONEncoder().encode(object) {
            UserDefaults.standard.set(data, forKey: key)
            return true
        }
        return false
    }
    
    func get<T: Codable>(_ type: T.Type, key: String) -> T? {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
        
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

struct StorageKeys {
    static let state: String = "state"
}

