//
// Created for WineBarChart
// by Stewart Lynch on 2022-07-14
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI
import Charts

struct TypesBarChartView: View {
    let wines: [Wine]
    @StateObject var vm = ChartViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                Chart(vm.groupings) { barEntry in
                    BarMark(x: .value("Wine Type", barEntry.name),
                            y: .value("In Stock", barEntry.inStock))
                    .foregroundStyle(by: .value("Wine Type", barEntry.name))
                }
                .chartPlotStyle { plotArea in
                    plotArea
                        .frame(height: 200)
                        .background(Color(.secondarySystemBackground))
                }
                .padding()
                .chartLegend(.hidden)
                .chartOverlay { proxy in
                    GeometryReader { nthGeoItem in
                        Rectangle().fill(.clear).contentShape(Rectangle())
                            .onTapGesture { value in
                                let x = value.x - nthGeoItem[proxy.plotAreaFrame].origin.x
                                let wineType: String? = proxy.value(atX: x)
                                if let wineType {
                                    vm.selectedType = WineType(rawValue: wineType)
                                }
                            }
                    }
                }
                Spacer()
                List(vm.selectedTypeWines) { wine in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(wine.variety.name).bold()
                            Spacer()
                            Text("In Stock \(wine.inStock)")
                                .font(.headline)
                        }
                        Text(wine.winery.name)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Wine Types in Stock")
        }
        .onAppear {
            vm.setup(wines)
            vm.chartType = .types
        }
    }
}

struct TypesBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        TypesBarChartView(wines: DataStore().wines)
    }
}
