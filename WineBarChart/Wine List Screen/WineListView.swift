//
// Created for WineBarChart
// by Stewart Lynch on 2022-07-11
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//
    

import SwiftUI

struct WineListView: View {
    @EnvironmentObject var store: DataStore
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Year", selection: $store.year) {
                    ForEach(DataStore.Year.allCases, id: \.self) { year in
                        Text(year.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                List {
                    HStack {
                        Spacer()
                        VStack {
                            LabeledContent("Wine IN ", value: "\(store.loggedIn)")
                                .foregroundColor(.green)
                            LabeledContent("Wine OUT ", value: "\(store.loggedOut)")
                                .foregroundColor(.red)
                            Divider()
                            LabeledContent("+/- ", value: "\(store.currentInventory)")
                        }
                        .font(.caption)
                        .bold()
                        .frame(width: 200)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.secondarySystemBackground)))
                        Spacer()
                    }
                    ForEach(store.filteredLogs) { log in
                        HStack {
                            VStack {
                                Image(systemName: log.action == .in ?
                                      "arrow.up.circle.fill" :
                                        "arrow.down.circle.fill")
                                .imageScale(.large)
                                Text("\(log.qty)")
                                    .bold()
                            }
                            .foregroundColor( log.action == .in ? .green : .red)
                            VStack(alignment: .leading) {
                                Text(log.wine.variety.name)
                                    .font(.title)
                                Text(log.wine.winery.name)
                                Text(log.date.formatted(date: .long, time: .omitted))
                            }
                        }
                    }
                }
                .listStyle(.inset)
            }
            .navigationTitle("Wine Inventory")
        }
    }
}

struct WineListView_Previews: PreviewProvider {
    static var previews: some View {
        WineListView()
            .environmentObject(DataStore())
    }
}

//struct RowView: View {
//    let title: String
//    let qty: Int
//    var body: some View {
//        GridRow {
//            Text(title)
//            Text( "\(qty)")
//                .gridColumnAlignment(.trailing)
//        }
//        .bold()
//    }
//}
