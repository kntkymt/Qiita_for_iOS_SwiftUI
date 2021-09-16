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

    @ObservedObject private var viewModel: StockViewModel

    @State private var isInitialOnAppear = true

    // MARK: - Initializer

    init(viewModel: StockViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            ItemListView(items: viewModel.items, isRefreshing: $viewModel.isRefreshing, onItemStockChangedHandler: viewModel.onItemStockChangedHandler, onRefresh: viewModel.fetchItems, onPaging: viewModel.fetchMoreItems)
                .navigationBarTitle("Stock", displayMode: .inline)
        }.onAppear {
            if isInitialOnAppear {
                viewModel.fetchItems()
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
