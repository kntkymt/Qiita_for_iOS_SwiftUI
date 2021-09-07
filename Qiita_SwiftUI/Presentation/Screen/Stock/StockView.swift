//
//  StockView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import SwiftUI

struct StockView: View {

    // MARK: - Property

    @ObservedObject private var viewModel: StockViewModel
    private let itemRepository: ItemRepository
    private let likeRepository: LikeRepository

    @State private var isInitialOnAppear = true

    // MARK: - Initializer

    init(stockRepository: StockRepository, itemRepository: ItemRepository, likeRepository: LikeRepository) {
        self.viewModel = StockViewModel(stockRepository: stockRepository)
        self.itemRepository = itemRepository
        self.likeRepository = likeRepository
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            ItemListView(items: $viewModel.items, isRefreshing: $viewModel.isRefreshing, onItemStockChangedHandler: viewModel.onItemStockChangedHandler, likeRepository: likeRepository, stockRepository: viewModel.stockRepository, onRefresh: viewModel.fetchItems, onPaging: viewModel.fetchMoreItems)
                .navigationBarTitle("Stock", displayMode: .inline)
        }.onAppear {
            if isInitialOnAppear {
                viewModel.fetchItems()
                isInitialOnAppear = false
            }
        }
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView(stockRepository: StockStubService(), itemRepository: ItemStubService(), likeRepository: LikeStubService())
    }
}
