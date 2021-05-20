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

    init(searchWord: String, itemRepository: ItemRepository) {
        viewModel = SearchResultViewModel(searchWord: searchWord, itemRepository: itemRepository)
    }

    // MARK: - Body

    var body: some View {
        ItemListView(items: $viewModel.items)
            .navigationTitle("キーワード: \(viewModel.searchWord)")
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(searchWord: "iOS", itemRepository: ItemStubService())
    }
}
