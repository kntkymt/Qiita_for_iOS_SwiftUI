//
//  StockView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import SwiftUI

struct StockView: View {

    // MARK: - Property

    @EnvironmentObject var repositoryContainer: RepositoryContainer

    @StateObject private var viewModel: StockViewModel

    @State private var isInitialOnAppear = true

    // MARK: - Initializer

    init(viewModel: StockViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            ItemListView(items: viewModel.items, onItemStockChangedHandler: viewModel.onItemStockChangedHandler, onRefresh: {
                await viewModel.fetchItems()
            }, onPaging: {
                await viewModel.fetchMoreItems()
            }).navigationBarTitle("Stock", displayMode: .inline)
        }.onAppear {
            if isInitialOnAppear {
                Task {
                    await viewModel.fetchItems()
                }
                isInitialOnAppear = false
            }
        }
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView(viewModel: StockViewModel(stockRepository: StockStubService()))
            .environmentObject(RepositoryContainerFactory.createStubs())
    }
}
