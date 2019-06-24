//
//  AppState.swift
//  Station Notifier
//
//  Created by Ryan Stone on 6/14/19.
//  Copyright © 2019 Ryan Stone. All rights reserved.
//

import SwiftUI
import Combine
import MapKit

final class AppState: BindableObject {
    var didChange = PassthroughSubject<AppState, Never>()
    var location = LocationManager.shared.currentLocation {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {}
}
