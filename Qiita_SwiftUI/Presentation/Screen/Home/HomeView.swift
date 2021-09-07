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

    @State private var isInitialOnAppear = true

    let likeRepository: LikeRepository
    let stockRepository: StockRepository

    // MARK: - Initializer

    init(itemRepository: ItemRepository, likeRepository: LikeRepository, stockRepository: StockRepository) {
        self.viewModel = HomeViewModel(itemRepository: itemRepository)
        self.likeRepository = likeRepository
        self.stockRepository = stockRepository
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            ItemListView(items: $viewModel.items, isRefreshing: $viewModel.isRefreshing, onItemStockChangedHandler: nil, likeRepository: likeRepository, stockRepository: stockRepository, onRefresh: viewModel.fetchItems, onPaging: viewModel.fetchMoreItems)
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
        HomeView(itemRepository: ItemStubService(), likeRepository: LikeStubService(), stockRepository: StockStubService())
    }
}
