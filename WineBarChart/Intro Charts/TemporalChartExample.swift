//
// Created for WineBarChart
// by Stewart Lynch on 2022-07-16
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import Charts
import SwiftUI

struct TemporalChartExample: View {
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
    let wine4 = WineLog(variety: "Chardonnay",
                        quantity: 15,
                        country: "United States",
                        entryDate: date(year: 2022, month: 7, day: 25))
    var body: some View {
        let wines = [wine1, wine2, wine3]
            NavigationStack {
                Chart(wines) {
                    BarMark(x: .value("Date", $0.entryDate, unit: .day),
                            y: .value("In Stock", $0.quantity))
                    .foregroundStyle(by: .value("Country", $0.country))
                }
                .chartXAxis {
                    AxisMarks { value in
                        AxisValueLabel(format: .dateTime.month().day(), centered: true)
                    }
                }
              .padding()
                Chart(wines) { wine in
                    BarMark(x: .value("Country", wine.country),
                            y: .value("Date", wine.entryDate, unit: .day))
                    .annotation(position: .overlay) {
                        Text("\(wine.quantity)")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .foregroundStyle(by: .value("Variety", wine.variety))
                }
                .chartYAxis {
                    AxisMarks { value in
                        AxisValueLabel(format: .dateTime.month().day(), centered: true)
                    }
                }
              .padding()
                .navigationTitle("Temporal Bar Chart")
            }
        }
}

struct TemporalChartExample_Previews: PreviewProvider {
    static var previews: some View {
        TemporalChartExample()
    }
}
