//
// Created for WineBarChart
// by Stewart Lynch on 2022-07-11
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//
    

import Foundation

class DataStore: ObservableObject {
    enum Year: String, CaseIterable {
       case all = "All Wines"
       case year1 = "2020"
       case year2 = "2021"
    }
    
    @Published var year: Year = .all
    @Published var wines: [Wine] = []
    @Published var varieties: [Variety] = []
    @Published var wineries: [Winery] = []
    @Published var logEntries: [LogEntry] = []
    @Published var tabSelection = 1
    
    var filteredLogs: [LogEntry] {
        switch year {
        case .all:
            return logEntries
                .sorted(using: KeyPathComparator(\.date))
        default:
            return logEntries.filter { $0.dateComponents.year == Int(year.rawValue)}
                .sorted(using: KeyPathComparator(\.date))
        }
    }

    init() {
        seedData()
    }
    
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
    
    func seedData() {
        if let filepath = Bundle.main.path(forResource: "WineData", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let data = contents.data(using: .utf8)!
                let decodedImport = try JSONDecoder().decode(Import.self, from: data)
                self.varieties = decodedImport.varieties
                self.wineries = decodedImport.wineries
                self.wines = decodedImport.wines.map({ wine in
                    Wine(id: wine.id,
                         inStock: wine.inStock,
                         variety: varieties.first(where: {$0.id == wine.varietyId})!,
                         winery: wineries.first(where: {$0.id == wine.wineryId})!)
                })
                self.logEntries = decodedImport.logEntries.map({ logEntry in
                    LogEntry(wine: wines.first(where: {$0.id == logEntry.wineID})!,
                             id: logEntry.id,
                             date: logEntry.date,
                             action: logEntry.action,
                             qty: logEntry.qty)
                })
                print("wines",wines.count)
                print("wineries", wineries.count)
                print("varieties", varieties.count)
                print("log entries", logEntries.count)
            } catch {
                print(error.localizedDescription)
                print("Could not decode data")
            }
        } else {
           print("Could not find WineLog.json in the bundle")
        }
    }
    
}
