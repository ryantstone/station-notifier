//
//  SetExtension.swift
//  Station Notifier
//
//  Created by Ryan Stone on 8/11/19.
//  Copyright © 2019 Ryan Stone. All rights reserved.
//

import Foundation

extension Set {
    mutating func append(contentsOf elements: [Element]) {
        elements.forEach { self.insert($0) }
    }

    mutating func mutatingMap(_ action: (inout Element) throws -> Void) rethrows {
        self = Set<Element>(try map { element in
            var element = element
            try action(&element)
            return element
        })
    }
}

extension Collection {
    func toDict<Key: Hashable>(key: KeyPath<Element, Key>) -> [Key: [Element]] {
        return self.reduce(into: [Key: [Element]]()) { (result, element) in
            if result[element[keyPath:key]] != nil {
                result[element[keyPath:key]]?.append(element)
            } else {
                result[element[keyPath:key]] = [element]
            }
        }
    }
}
