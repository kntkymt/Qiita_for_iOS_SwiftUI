//
//  SearchResultView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/21.
//

import SwiftUI
import Model

public struct SearchResultView: View {

    // MARK: - Property

    @EnvironmentObject var repositoryContainer: RepositoryContainer

    @StateObject private var viewModel: SearchResultViewModel

    // MARK: - Initializer

    init(viewModel: SearchResultViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - Body

    public var body: some View {
        GeometryReader { reader in
            ItemListView(items: viewModel.items, onItemStock: nil, onInit: {
                await viewModel.fetchItems()
            }, onRefresh: {
                await viewModel.fetchItems()
            }, onPaging: {
                await viewModel.fetchMoreItems()
            }, header: {
                if case .tag(let tag) = viewModel.searchType {
                    // タグ検索の場合、結果が空にならないという想定
                    TagInformationView(viewModel: TagInformationViewModel(tag: tag, tagRepository: repositoryContainer.tagRepository))
                } else if let items = viewModel.items, items.isEmpty {
                    // タグ検索以外 かつ 結果が読み込まれた かつ 結果が空
                    EmptyContentView(title: "記事がありません")
                        .frame(height: reader.size.height)
                }
            })
            .navigationTitle(navigationTitle)
        }
    }

    var navigationTitle: String {
        switch viewModel.searchType {
        case .tag(let tag): return "タグ: \(tag.id)"
        case .word(let word): return "キーワード: \(word)"
        }
    }
}
