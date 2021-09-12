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

    @State private var isInitialOnAppear = true

    // MARK: - Initializer

    init(searchType: SearchType, itemRepository: ItemRepository, likeRepository: LikeRepository, stockRepository: StockRepository) {
        viewModel = SearchResultViewModel(searchType: searchType, itemRepository: itemRepository)
        self.likeRepository = likeRepository
        self.stockRepository = stockRepository
    }

    // MARK: - Body

    var body: some View {
        /// FIXME: ItemListViewのHeaderが左寄せになっている問題
        /// 現在はSearchResultの方で幅を指定して対応
        GeometryReader { reader in
            ItemListView(items: $viewModel.items, isRefreshing: $viewModel.isRefreshing, onItemStockChangedHandler: nil, likeRepository: likeRepository, stockRepository: stockRepository, onRefresh: viewModel.fetchItems, onPaging: viewModel.fetchMoreItems, header: {
                if case .tag(let tag) = viewModel.searchType {
                    TagInformationView(tag: tag)
                        .frame(width: reader.size.width - 32)
                }
            })
                .navigationTitle(navigationTitle)
                .onAppear {
                    if isInitialOnAppear {
                        viewModel.fetchItems()
                        isInitialOnAppear = false
                    }
                }
        }
    }

    var navigationTitle: String {
        switch viewModel.searchType {
        case .tag(let tag): return "タグ: \(tag.id)"
        case .word(let word): return "キーワード: \(word)"
        }
    }
}

struct TagInformationView: View {

    // MARK: - Property

    var tag: ItemTag

    // MARK: - Body

    var body: some View {
        VStack(alignment: .center) {
            ImageView(url: tag.iconUrl!)
                .frame(width: 150, height: 150)

            Text(tag.id)

            HStack(spacing: 32) {
                VStack {
                    Text(tag.itemsCount.description)
                    Text("記事")
                }.frame(width: 100)

                VStack {
                    Text(tag.followersCount.description)
                    Text("フォロワー")
                }.frame(width: 100)
            }
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(searchType: .word("iOS"), itemRepository: ItemStubService(), likeRepository: LikeStubService(), stockRepository: StockStubService())

        SearchResultView(searchType: .tag(ItemTag(iconUrl: URL(string: "https://avatars2.githubusercontent.com/u/44288050?v=4")!, followersCount: 10, id: "iOS", itemsCount: 10)), itemRepository: ItemStubService(), likeRepository: LikeStubService(), stockRepository: StockStubService())
    }
}
