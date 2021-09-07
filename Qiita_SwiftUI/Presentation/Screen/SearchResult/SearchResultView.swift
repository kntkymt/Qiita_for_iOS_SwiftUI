//
//  SearchResultView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/21.
//

import SwiftUI

struct SearchResultView: View {

    // MARK: - Property

    @ObservedObject private var viewModel: SearchResultViewModel
    private let likeRepository: LikeRepository
    private let stockRepository: StockRepository

    // MARK: - Initializer

    init(searchType: SearchType, itemRepository: ItemRepository, likeRepository: LikeRepository, stockRepository: StockRepository) {
        viewModel = SearchResultViewModel(searchType: searchType, itemRepository: itemRepository)
        self.likeRepository = likeRepository
        self.stockRepository = stockRepository
    }

    // MARK: - Body

    var body: some View {
        ItemListView(items: $viewModel.items, isRefreshing: $viewModel.isRefreshing, onItemStockChangedHandler: nil, likeRepository: likeRepository, stockRepository: stockRepository, onRefresh: viewModel.fetchItems, onPaging: viewModel.fetchMoreItems)
            .navigationTitle(navigationTitle)
    }

    var navigationTitle: String {
        switch viewModel.searchType {
        case .tag(let tag): return "タグ: \(tag.id)"
        case .word(let word): return "キーワード: \(word)"
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(searchType: .word("iOS"), itemRepository: ItemStubService(), likeRepository: LikeStubService(), stockRepository: StockStubService())
    }
}
