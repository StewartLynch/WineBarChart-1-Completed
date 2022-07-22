//
// Created for WineBarChart
// by Stewart Lynch on 2022-07-13
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import Foundation

struct Import: Codable {
    struct LogEntry: Codable {
        let wineID: String
        let id: String
        let date: Date
        let action: Action
        let qty: Int
    }
    
    struct Wine: Codable {
        let id: String
        let inStock: Int
        let varietyId: String
        let wineryId: String
    }
    
    let logEntries: [LogEntry]
    let wines: [Wine]
    let varieties: [Variety]
    let wineries: [Winery]
}
