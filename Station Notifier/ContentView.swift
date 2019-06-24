//
//  ContentView.swift
//  Station Notifier
//
//  Created by Ryan Stone on 6/7/19.
//  Copyright © 2019 Ryan Stone. All rights reserved.
//

import SwiftUI
import Combine
import MapKit

struct ContentView : View {

    @EnvironmentObject var appState: AppState
    
    var location: String {
        appState.location
            .map { "\($0.coordinate.longitude) \($0.coordinate.latitude)" }
            .replaceEmpty(with: "Invalid Location")
            .output
    }
   
    
    
    var body: some View {
        Text(location)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
