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
    private let tagRepository: TagRepository

    @State private var isInitialOnAppear = true

    // MARK: - Initializer

    init(searchType: SearchType, itemRepository: ItemRepository, likeRepository: LikeRepository, stockRepository: StockRepository, tagRepository: TagRepository) {
        viewModel = SearchResultViewModel(searchType: searchType, itemRepository: itemRepository)
        self.likeRepository = likeRepository
        self.stockRepository = stockRepository
        self.tagRepository = tagRepository
    }

    // MARK: - Body

    var body: some View {
        /// FIXME: ItemListViewのHeaderが左寄せになっている問題
        /// 現在はSearchResultの方で幅を指定して対応
        GeometryReader { reader in
            ItemListView(items: $viewModel.items, isRefreshing: $viewModel.isRefreshing, onItemStockChangedHandler: nil, likeRepository: likeRepository, stockRepository: stockRepository, onRefresh: viewModel.fetchItems, onPaging: viewModel.fetchMoreItems, header: {
                if case .tag(let tag) = viewModel.searchType {
                    TagInformationView(tag: tag, tagRepository: tagRepository)
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

    @ObservedObject private var viewModel: TagInformationViewModel
    @State private var isInitialOnAppear = true

    // MARK: - Initializer

    init(tag: ItemTag, tagRepository: TagRepository) {
        self.viewModel = TagInformationViewModel(tag: tag, tagRepository: tagRepository)

        /// FIXME: ItemListItemと同様にonAppearでやると再描画されて状態が上書きされる
        viewModel.checkIsFollowed()
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            ImageView(url: viewModel.tag.iconUrl!)
                .frame(width: 150, height: 150)

            Text(viewModel.tag.id)
                .font(.system(size: 20, weight: .medium))

            HStack(spacing: 32) {
                ContributionView(title: "記事", count: viewModel.tag.itemsCount)
                ContributionView(title: "フォロワー", count: viewModel.tag.followersCount)
            }

            if viewModel.isFollowed {
                Text("フォロー中")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .border(Color("brand"), width: 1)
                    .foregroundColor(Color.white)
                    .background(Color("brand"))
                    .frame(width: 150, height: 30)
                    .onTapGesture { viewModel.unfollow() }
            } else {
                Text("フォローする")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .border(Color("brand"), width: 1)
                    .foregroundColor(Color("brand"))
                    .background(Color.clear)
                    .frame(width: 150, height: 30)
                    .onTapGesture { viewModel.follow() }
            }
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(searchType: .word("iOS"), itemRepository: ItemStubService(), likeRepository: LikeStubService(), stockRepository: StockStubService(), tagRepository: TagStubService())

        SearchResultView(searchType: .tag(ItemTag(iconUrl: URL(string: "https://avatars2.githubusercontent.com/u/44288050?v=4")!, followersCount: 10, id: "iOS", itemsCount: 10)), itemRepository: ItemStubService(), likeRepository: LikeStubService(), stockRepository: StockStubService(), tagRepository: TagStubService())
    }
}
