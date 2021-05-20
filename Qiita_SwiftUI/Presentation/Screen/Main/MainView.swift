//
//  MainView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import SwiftUI

struct MainView: View {

    // MARK: - Property

    var authRepository: AuthRepository
    var itemRepository: ItemRepository
    var stockRepository: StockRepository
    var tagRepository: TagRepository

    // MARK: - Body

    var body: some View {
        TabView {
            HomeView(itemRepository: itemRepository)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            SearchView(tagRepository: tagRepository)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            StockView(stockRepository: stockRepository)
                .tabItem {
                    Image(systemName: "folder")
                    Text("Stock")
                }
            ProfileView(authRepository: authRepository, itemRepository: itemRepository)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }.accentColor(Color("brand"))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(authRepository: AuthStubService(), itemRepository: ItemStubService(), stockRepository: StockStubService(), tagRepository: TagStubService())
    }
}
