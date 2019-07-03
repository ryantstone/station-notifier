//
//  ContentView.swift
//  Station Notifier
//
//  Created by Ryan Stone on 6/7/19.
//  Copyright © 2019 Ryan Stone. All rights reserved.
//

import SwiftUI
import Combine
import CoreLocation

struct ContentView : View {
    
    @ObjectBinding var state: AppState
    var loc: String = "Location Unavailable"
    var location: AnyPublisher<String, Never> {
        state.currentLocation
            .removeDuplicates()
            .map({ return "\($0.coordinate.longitude), \($0.coordinate.latitude)" })
            .replaceError(with: "Location Unavailable")
            .eraseToAnyPublisher()
    }
    
    var body: some View {
        HStack {
            Text(loc)
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(state: AppState())
    }
}
#endif
