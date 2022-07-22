//
// Created for WineBarChart
// by Stewart Lynch on 2022-07-13
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//
    

import Foundation

struct LogEntry: Identifiable {
    let wine: Wine
    let id: String
    let date: Date
    let action: Action
    let qty: Int
    
    var dateComponents: DateComponents {
        var dateComponents = Calendar.current.dateComponents(
            [.month,
             .day,
             .year],
            from: date)
        dateComponents.timeZone = TimeZone.current
        dateComponents.calendar = Calendar(identifier: .gregorian)
        return dateComponents
    }
}
