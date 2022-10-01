//
// Created for WineBarChart
// by Stewart Lynch on 2022-07-18
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//
    
import Foundation

class WineLogViewModel: ObservableObject {
    
    
    var logEntries: [LogEntry]?
    func setup(logEntries: [LogEntry]) {
        self.logEntries = logEntries
    }
    
    @Published var year: Year = .all
    var filteredLogs: [LogEntry] {
        if let logEntries {
            switch year {
            case .all:
                return logEntries
                    .sorted(using: KeyPathComparator(\.date))
            default:
                return logEntries.filter { $0.dateComponents.year == Int(year.rawValue)}
                    .sorted(using: KeyPathComparator(\.date))
            }
        } else {
            return []
        }
    }
    
    // For Wine Log View
    var loggedIn: Int {
        filteredLogs
            .filter{$0.action == .in}
            .map {$0.qty}
            .reduce(0, +)
    }
    
    var loggedOut: Int {
        filteredLogs
            .filter{$0.action == .out}
            .map {$0.qty}
            .reduce(0, +)
    }
    
    var currentInventory: Int {
        loggedIn - loggedOut
    }
    
}
