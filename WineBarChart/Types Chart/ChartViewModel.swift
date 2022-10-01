//
// Created for WineBarChart
// by Stewart Lynch on 2022-07-19
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import Foundation

class ChartViewModel: ObservableObject {
    @Published var wines: [Wine]?
    @Published var selectedType: WineType?
    @Published var chartType: ChartType = .types

    func setup(_ wines: [Wine]) {
        self.wines = wines
    }
    
    struct BarEntry: Identifiable {
        var name: String
        var inStock: Int
        var id: String {
            name
        }
    }
    
    enum ChartType: String, CaseIterable, Identifiable {
        case wineries, varieties, types
        var id: String {
            self.rawValue
        }
    }
    
    var allEntries: [BarEntry] {
        if let wines {
            switch chartType {
            case .wineries:
                return wines.map {BarEntry(name: $0.winery.name, inStock: $0.inStock)}
            case .varieties:
                return wines.map {BarEntry(name: $0.variety.name, inStock: $0.inStock)}
            case .types:
                return wines.map {BarEntry(name: $0.variety.wineType.rawValue, inStock: $0.inStock)}
            }
            
        } else {
            return []
        }
    }
    
    var grouping: [String : [BarEntry]] {
        Dictionary(grouping: allEntries, by: {$0.name})
    }
    
    var groupings: [BarEntry] {
        var groupings: [BarEntry] = []
        for (name, entries) in grouping {
            let ttl = entries.reduce(0) {$0 + $1.inStock}
            groupings.append(BarEntry(name: name, inStock: ttl))
        }
        return groupings.filter {$0.inStock > 0}
            .sorted(using: KeyPathComparator(\.name))
    }
    
    var selectedTypeWines: [Wine] {
        if let wines, let selectedType {
            return wines.filter {$0.variety.wineType == selectedType && $0.inStock > 0}
                .sorted(using: KeyPathComparator(\.variety.name))
        } else {
            return []
        }
    }
}
