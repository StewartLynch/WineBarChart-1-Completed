//
// Created for WineBarChart
// by Stewart Lynch on 2022-07-16
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI
import Charts

struct WineLog: Identifiable {
    var variety: String
    var quantity: Int
    var country: String
    var entryDate: Date
    var id = UUID()
}

func date(year: Int, month: Int, day: Int) -> Date {
    Calendar.current.date(from: .init(year: year, month: month, day: day)) ?? Date()
}

struct NominalChartExample: View {
         let wine1 = WineLog(variety: "Chardonnay",
                         quantity: 15,
                         country: "Canada",
                         entryDate: date(year: 2022, month: 7, day: 22))
        let wine2 = WineLog(variety: "Merlot",
                         quantity: 20,
                         country: "United States",
                         entryDate: date(year: 2022, month: 7, day: 23))
    let wine3 = WineLog(variety: "Chardonnay",
                     quantity: 15,
                     country: "United States",
                     entryDate: date(year: 2022, month: 7, day: 24))

    var body: some View {
        let wines = [wine1, wine2, wine3]
        NavigationStack {
            Chart {
                BarMark(x: .value("Country", wine1.country),
                        y: .value("In Stock", wine1.quantity))
                .foregroundStyle(by: .value("Variety", wine1.variety))
                BarMark(x: .value("Country", wine2.country),
                        y: .value("In Stock", wine2.quantity))
                .foregroundStyle(by: .value("Variety", wine2.variety))
                BarMark(x: .value("Country", wine3.country),
                        y: .value("In Stock", wine3.quantity))
                .foregroundStyle(by: .value("Variety", wine3.variety))
            }
            .padding()
            Chart(wines) {
                BarMark(x: .value("In Stock", $0.quantity),
                        y: .value("Country", $0.country))
                .foregroundStyle(by: .value("Variety", $0.variety))
            }
            .padding()
            .navigationTitle("Nominal Bar Chart")
        }
    }
}

struct NominalChartExample_Previews: PreviewProvider {
    static var previews: some View {
        NominalChartExample()
    }
}
