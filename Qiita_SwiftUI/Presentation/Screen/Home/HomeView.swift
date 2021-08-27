//
//  HomeView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/14.
//

import SwiftUI

struct HomeView: View {

    // MARK: - Property

    @ObservedObject private var viewModel: HomeViewModel

    // MARK: - Initializer

    init(itemRepository: ItemRepository) {
        self.viewModel = HomeViewModel(itemRepository: itemRepository)
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            ItemListView(items: $viewModel.items, isRefreshing: $viewModel.isRefreshing, onRefresh: viewModel.fetchItems, onPaging: viewModel.fetchMoreItems)
                .navigationBarTitle("Home", displayMode: .inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(itemRepository: ItemStubService())
    }
}
