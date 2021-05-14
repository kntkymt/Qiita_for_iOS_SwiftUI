//
//  MainView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import SwiftUI

struct MainView: View {

    // MARK: - Property

    var itemRepository: ItemRepository
    var stockRepository: StockRepository

    // MARK: - Body

    var body: some View {
        TabView {
            HomeView(itemRepository: itemRepository)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            StockView(stockRepository: stockRepository)
                .tabItem {
                    Image(systemName: "folder")
                    Text("Stock")
                }
            Text("Profile")
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(itemRepository: ItemStubService(), stockRepository: StockStubService())
    }
}
