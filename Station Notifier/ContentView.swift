//
//  ContentView.swift
//  Station Notifier
//
//  Created by Ryan Stone on 6/7/19.
//  Copyright © 2019 Ryan Stone. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView : View {

    var appState = AppState()

    var body: some View {
        Text(appState[\.location])
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
