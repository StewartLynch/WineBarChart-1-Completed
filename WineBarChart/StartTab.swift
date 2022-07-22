//
// Created for WineBarChart
// by Stewart Lynch on 2022-07-14
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//
    

import SwiftUI

struct StartTab: View {
    @EnvironmentObject var store: DataStore
    var body: some View {
        TabView(selection: $store.tabSelection) {
           WineListView()
                .tabItem {
                    Label("My Wine Cellar",
                          image: store.tabSelection == 1 ? "My_Wineries-Active" : "My_Wineries")
                }.tag(1)
           TypesBarChartView()
                .tabItem {
                    Label("Types", systemImage: "chart.bar")
                }.tag(2)
            GroupingChartView()
                .tabItem {
                    Label("Groupings",
                          image: store.tabSelection == 3 ? "GroupingsActive" : "Groupings")
                }.tag(3)
            InOutBarChartView()
                .tabItem {
                    Label("In/Out",
                          image: store.tabSelection == 4 ? "My_Wine_Cellar-Active" : "My_Wine_Cellar")
                }.tag(4)
        }
    }
}

struct StartTab_Previews: PreviewProvider {
    static var previews: some View {
        StartTab()
            .environmentObject(DataStore())
    }
}
