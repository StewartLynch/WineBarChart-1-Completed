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
    @Published var wines: [Wine] = []
    @Published var varieties: [Variety] = []
    @Published var wineries: [Winery] = []
    @Published var logEntries: [LogEntry] = []
    @Published var tabSelection = 1

    init() {
        seedData()
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
                
                // build new model now
                print(wines.count)
                print(logEntries.count)
            } catch {
                print(error.localizedDescription)
                print("Could not decode data")
            }
        } else {
           print("Could not find WineLog.json in the bundle")
        }
    }
    
}
