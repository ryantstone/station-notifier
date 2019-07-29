import UIKit

extension CustomStringConvertible {
    var description: String {
//        var description = type(of: self)
        let mirror = Mirror(reflecting: self)
        return mirror.children.compactMap { (child) -> String? in
            if let label = child.label {
                return "\(label): \(child.value)"
            }
            return nil
        }
        .joined(separator: "\n")
    }
}
