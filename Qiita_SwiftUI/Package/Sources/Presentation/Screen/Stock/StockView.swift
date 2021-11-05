//
//  StockView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import SwiftUI

public struct StockView: View {

    // MARK: - Property

    @EnvironmentObject var repositoryContainer: RepositoryContainer

    @StateObject private var viewModel: StockViewModel

    // MARK: - Initializer

    init(viewModel: StockViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - Body

    public var body: some View {
        NavigationView {
            GeometryReader { reader in
                ItemListView(items: viewModel.items, onItemStock: viewModel.onItemStock, onInit: {
                    await viewModel.fetchItems()
                }, onRefresh: {
                    await viewModel.fetchItems()
                }, onPaging: {
                    await viewModel.fetchMoreItems()
                }, header: {
                    if !viewModel.isLoading && viewModel.items.isEmpty {
                        EmptyContentView(title: "ストックされた記事がありません")
                            .frame(width: reader.size.width - 32, height: reader.size.height)
                    }
                })
            }.navigationBarTitle("Stock", displayMode: .inline)
        }
    }
}

//struct StockView_Previews: PreviewProvider {
//    static var previews: some View {
//        StockView(viewModel: StockViewModel(stockRepository: StockStubService()))
//            .environmentObject(RepositoryContainerFactory.createStubs())
//    }
//}
