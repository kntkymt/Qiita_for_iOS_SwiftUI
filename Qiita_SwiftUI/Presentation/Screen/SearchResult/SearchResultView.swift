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

    // MARK: - Initializer

    init(searchType: SearchType, itemRepository: ItemRepository) {
        viewModel = SearchResultViewModel(searchType: searchType, itemRepository: itemRepository)
    }

    // MARK: - Body

    var body: some View {
        ItemListView(items: $viewModel.items, isRefreshing: $viewModel.isRefreshing, onRefresh: viewModel.fetchItems)
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
        SearchResultView(searchType: .word("iOS"), itemRepository: ItemStubService())
    }
}
