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

    @State private var isInitialOnAppear = true

    // MARK: - Initializer

    init(viewModel: SearchResultViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - Body

    public var body: some View {
        /// FIXME: ItemListViewのHeaderが左寄せになっている問題
        /// 現在はSearchResultの方で幅を指定して対応
        GeometryReader { reader in
            ItemListView(items: viewModel.items, onItemStock: nil, onRefresh: {
                await viewModel.fetchItems()
            }, onPaging: {
                await viewModel.fetchMoreItems()
            }, header: {
                if !viewModel.isLoading && viewModel.items.isEmpty {
                    EmptyContentView(title: "記事がありません")
                        .frame(width: reader.size.width - 32, height: reader.size.height)
                } else {
                    if case .tag(let tag) = viewModel.searchType {
                        TagInformationView(viewModel: TagInformationViewModel(tag: tag, tagRepository: repositoryContainer.tagRepository))
                            .frame(width: reader.size.width - 32)
                    }
                }
            })
            .navigationTitle(navigationTitle)
            .onAppear {
                if isInitialOnAppear {
                    Task {
                        await viewModel.fetchItems()
                    }
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
