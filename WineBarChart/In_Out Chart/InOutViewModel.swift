//
// Created for WineBarChart
// by Stewart Lynch on 2022-07-19
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import Foundation

class InOutViewModel: ObservableObject {
    @Published var logEntries: [LogEntry]?
    @Published var year: Year = .year1
    
    func setup(_ logEntries: [LogEntry]) {
        self.logEntries = logEntries
    }
    
    var filteredLogs: [LogEntry] {
        if let logEntries {
            switch year {
            case .all:
                return logEntries
                    .sorted(using: KeyPathComparator(\.date))
            default:
                return logEntries.filter {$0.dateComponents.year == Int(year.rawValue)}
                    .sorted(using: KeyPathComparator(\.date))
            }
        } else {
            return []
        }
    }
    
    struct MonthlyLog: Identifiable {
        var id = UUID()
        let month: Int
        let action: Action
        let qty: Int
        
        var actual: Int {
            action == .out ? -qty : qty
        }
        
        var theMonth: String {
            switch month {
            case 1:
                return "Jan"
            case 2:
                return "Feb"
            case 3:
                return "Mar"
            case 4:
                return "Apr"
            case 5:
                return "May"
            case 6:
                return "Jun"
            case 7:
                return "Jul"
            case 8:
                return "Aug"
            case 9:
                return "Sep"
            case 10:
                return "Oct"
            case 11:
                return "Nov"
            default:
                return "Dec"
            }
        }
    }
    
    var groupedByMonth: [Int : [LogEntry]] {
        Dictionary(grouping: filteredLogs, by: {$0.dateComponents.month!})
    }
    
    var allLogs: [MonthlyLog] {
        var allLogs: [MonthlyLog] = []
        for (month, logs) in groupedByMonth {
            let winesIn = logs.filter {$0.action == .in}
            let qtyIn = winesIn.reduce(0) { $0 + $1.qty}
            allLogs.append(MonthlyLog(month: month, action: .in, qty: qtyIn))
            let winesOut = logs.filter {$0.action == .out}
            let qtyOut = winesOut.reduce(0) { $0 + $1.qty}
            allLogs.append(MonthlyLog(month: month, action: .out, qty: qtyOut))
        }
        return allLogs
            .sorted(using: KeyPathComparator(\.month))
    }
}
