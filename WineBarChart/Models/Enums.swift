//
// Created for WineBarChart
// by Stewart Lynch on 2022-07-13
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//
    

import Foundation

enum Action: String, Codable,CaseIterable {
    case `in`, out
}

enum WineType: String, Codable, CaseIterable {
    case Red, White, Dessert, Fortified, Sparkling, Rosé, Unkown
}
