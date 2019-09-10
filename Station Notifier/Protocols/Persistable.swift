import Foundation

protocol Persistable {
    func set<T: Codable>(_ object: T, key: String) -> Bool
    func get<T: Codable>(_ type: T.Type, key: String) -> T?
}
