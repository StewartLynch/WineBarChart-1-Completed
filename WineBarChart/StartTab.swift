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
            WineListView(logEntries: store.logEntries)
                .tabItem {
                    Label("My Wine Cellar",
                          image: store.tabSelection == 1 ? "My_Wineries-Active" : "My_Wineries")
                }.tag(1)
            TypesBarChartView(wines: store.wines)
                .tabItem {
                    Label("Types", systemImage: "chart.bar")
                }.tag(2)
            GroupingChartView(wines: store.wines)
                .tabItem {
                    Label("Groupings",
                          image: store.tabSelection == 3 ? "GroupingsActive" : "Groupings")
                }.tag(3)
            InOutBarChartView(logEntries: store.logEntries)
                .tabItem {
                    Label("In/Out",
                          image: store.tabSelection == 4 ? "My_Wine_Cellar-Active" : "My_Wine_Cellar")
                }.tag(4)
        }
        .onAppear {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = UIColor.systemBackground
                UITabBar.appearance().standardAppearance = tabBarAppearance

                if #available(iOS 15.0, *) {
                    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                }
        }
    }
}

struct StartTab_Previews: PreviewProvider {
    static var previews: some View {
        StartTab()
            .environmentObject(DataStore())
    }
}
