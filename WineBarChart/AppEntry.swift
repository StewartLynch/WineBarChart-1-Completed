//
// Created for WineBarChart
// by Stewart Lynch on 2022-07-11
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI

@main
struct AppEntry: App {
    var store = DataStore()
    var body: some Scene {
        WindowGroup {
            StartTab()
                .environmentObject(store)
        }
    }
}
