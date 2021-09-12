//
//  MainView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import SwiftUI

struct MainView: View {

    // MARK: - Property

    @EnvironmentObject var repositoryContainer: RepositoryContainer

    // MARK: - Body

    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel(itemRepository: repositoryContainer.itemRepository))
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            SearchView(viewModel: SearchViewModel(tagRepository: repositoryContainer.tagRepository))
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            StockView(viewModel: StockViewModel(stockRepository: repositoryContainer.stockRepository))
                .tabItem {
                    Image(systemName: "folder")
                    Text("Stock")
                }
            ProfileView(viewModel: ProfileViewModel(authRepository: repositoryContainer.authRepository, itemRepository: repositoryContainer.itemRepository))
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }.accentColor(Color("brand"))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(RepositoryContainerFactory.createStubs())
    }
}
