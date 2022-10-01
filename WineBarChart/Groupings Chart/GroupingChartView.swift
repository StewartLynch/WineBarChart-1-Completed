//
// Created for WineBarChart
// by Stewart Lynch on 2022-07-13
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI
import Charts

struct GroupingChartView: View {
    var wines: [Wine]
    @StateObject var vm = ChartViewModel()
    var frameHeight = 400.0
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("In Stock")
                    ScrollView(.vertical) {
                        Chart(vm.groupings) { grouping in
                            BarMark(x: .value("In Stock", grouping.inStock),
                                    y: .value("Category", grouping.name))
                            .annotation(position: .trailing) {
                                Text("\(grouping.inStock)")
                                    .font(.caption)
                            }
                        }
                        .chartPlotStyle { plotArea in
                            plotArea
                                .frame(height: CGFloat(frameHeight * Double(vm.groupings.count))/10)
                        }
                        .chartXAxis {
                            AxisMarks(preset: .automatic, position: .top)
                        }
                    }
                    .frame(height: frameHeight)
                }
                Section {
                    Picker("Category", selection: $vm.chartType) {
                        ForEach(ChartViewModel.ChartType.allCases.dropLast()) { category in
                            Text(category.rawValue.capitalized).tag(category)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle(vm.chartType.rawValue.capitalized)
        }
        .onAppear {
            vm.setup(wines)
            vm.chartType = .wineries
        }
    }
}

struct GroupingChartView_Previews: PreviewProvider {
    static var previews: some View {
        GroupingChartView(wines: DataStore().wines)
    }
}
