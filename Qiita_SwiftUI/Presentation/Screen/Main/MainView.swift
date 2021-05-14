//
//  MainView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView(itemRepository: AppContainer.shared.itemRepository)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            Text("Stock")
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
        MainView()
    }
}
