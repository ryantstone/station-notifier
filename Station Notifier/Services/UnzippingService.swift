//
//  UnzippingService.swift
//  Station Notifier
//
//  Created by Ryan Stone on 8/11/19.
//  Copyright © 2019 Ryan Stone. All rights reserved.
//

import Foundation

class UnzippingService {
    
    lazy var fileManager = FileManager()
    let url: URL
    
    static func unzip(url: URL) throws -> URL {
        try UnzippingService(url).perform()
    }
    
    init(_ url: URL) {
        self.url = url
    }
    
    private func perform() throws -> URL {
        let currentWorkingPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        var destinationURL = URL(fileURLWithPath: currentWorkingPath.path)
        destinationURL.appendPathComponent(UUID().uuidString)
        try fileManager.createDirectory(at: destinationURL, withIntermediateDirectories: true, attributes: nil)
        try fileManager.unzipItem(at: url, to: destinationURL)
        return destinationURL
    }
}
