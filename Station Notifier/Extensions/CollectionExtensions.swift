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
