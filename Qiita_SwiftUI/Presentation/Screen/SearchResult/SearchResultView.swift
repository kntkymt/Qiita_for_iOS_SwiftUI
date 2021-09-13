//
//  SearchResultView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/21.
//

import SwiftUI

struct SearchResultView: View {

    // MARK: - Property

    @EnvironmentObject var repositoryContainer: RepositoryContainer

    @ObservedObject private var viewModel: SearchResultViewModel

    @State private var isInitialOnAppear = true

    // MARK: - Initializer

    init(viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    var body: some View {
        /// FIXME: ItemListViewのHeaderが左寄せになっている問題
        /// 現在はSearchResultの方で幅を指定して対応
        GeometryReader { reader in
            ItemListView(items: $viewModel.items, isRefreshing: $viewModel.isRefreshing, onItemStockChangedHandler: nil, onRefresh: viewModel.fetchItems, onPaging: viewModel.fetchMoreItems, header: {
                if case .tag(let tag) = viewModel.searchType {
                    TagInformationView(viewModel: TagInformationViewModel(tag: tag, tagRepository: repositoryContainer.tagRepository))
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

struct SearchResultView_Previews: PreviewProvider {

    private static let tag = ItemTag(iconUrl: URL(string: "https://avatars2.githubusercontent.com/u/44288050?v=4")!, followersCount: 10, id: "iOS", itemsCount: 10)

    static var previews: some View {
        SearchResultView(viewModel: SearchResultViewModel(searchType: .word("iOS"), itemRepository: ItemStubService()))
            .environmentObject(RepositoryContainerFactory.createStubs())

        SearchResultView(viewModel: SearchResultViewModel(searchType: .tag(tag), itemRepository: ItemStubService()))
            .environmentObject(RepositoryContainerFactory.createStubs())
    }
}
