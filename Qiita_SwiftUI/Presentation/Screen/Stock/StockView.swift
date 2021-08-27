//
//  StockView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import SwiftUI

struct StockView: View {

    // MARK: - Property

    @ObservedObject private var viewModel: StockViewModel

    // MARK: - Initializer

    init(stockRepository: StockRepository) {
        self.viewModel = StockViewModel(stockRepository: stockRepository)
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            ItemListView(items: $viewModel.items, isRefreshing: $viewModel.isRefreshing, onRefresh: viewModel.fetchItems)
                .navigationBarTitle("Stock", displayMode: .inline)
        }
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView(stockRepository: StockStubService())
    }
}
