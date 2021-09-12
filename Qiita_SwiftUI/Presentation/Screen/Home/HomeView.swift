//
//  HomeView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/14.
//

import SwiftUI

struct HomeView: View {

    // MARK: - Property

    @EnvironmentObject var repositoryContainer: RepositoryContainer

    @ObservedObject private var viewModel: HomeViewModel

    @State private var isInitialOnAppear = true


    // MARK: - Initializer

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            ItemListView(items: $viewModel.items, isRefreshing: $viewModel.isRefreshing, onItemStockChangedHandler: nil, onRefresh: viewModel.fetchItems, onPaging: viewModel.fetchMoreItems)
                .navigationBarTitle("Home", displayMode: .inline)
        }.onAppear {
            if isInitialOnAppear {
                viewModel.fetchItems()
                isInitialOnAppear = false
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(itemRepository: ItemStubService()))
    }
}
