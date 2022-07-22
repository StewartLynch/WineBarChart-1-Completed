//
// Created for WineBarChart
// by Stewart Lynch on 2022-07-13
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import Foundation


struct Wine: Identifiable {
    let id: String
    let inStock: Int
    let variety: Variety
    let winery: Winery
}
