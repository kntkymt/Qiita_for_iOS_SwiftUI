//
//  MainView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import SwiftUI

struct MainView: View {

    // MARK: - Property

    var likeRepository: LikeRepository
    var authRepository: AuthRepository
    var itemRepository: ItemRepository
    var stockRepository: StockRepository
    var tagRepository: TagRepository

    // MARK: - Body

    var body: some View {
        TabView {
            HomeView(itemRepository: itemRepository, likeRepository: likeRepository, stockRepository: stockRepository)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            SearchView(tagRepository: tagRepository, itemRepository: itemRepository, likeRepository: likeRepository, stockRepository: StockStubService())
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            StockView(stockRepository: stockRepository, itemRepository: itemRepository, likeRepository: likeRepository)
                .tabItem {
                    Image(systemName: "folder")
                    Text("Stock")
                }
            ProfileView(authRepository: authRepository, itemRepository: itemRepository, likeRepository: likeRepository, stockRepository: stockRepository)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }.accentColor(Color("brand"))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(likeRepository: LikeStubService(), authRepository: AuthStubService(), itemRepository: ItemStubService(), stockRepository: StockStubService(), tagRepository: TagStubService())
    }
}
