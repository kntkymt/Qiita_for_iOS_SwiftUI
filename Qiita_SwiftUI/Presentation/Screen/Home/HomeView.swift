//
//  HomeView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/14.
//

import SwiftUI

struct HomeView: View {

    // MARK: - Property

    @EnvironmentObject var repositoryContainer: RepositoryContainer

    @StateObject private var viewModel: HomeViewModel

    @State private var isInitialOnAppear = true


    // MARK: - Initializer

    init(viewModel: HomeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            ItemListView(items: viewModel.items, isRefreshing: $viewModel.isRefreshing, onItemStockChangedHandler: nil, onRefresh: {
                Task {
                    await viewModel.fetchItems()
                }
            }, onPaging: {
                Task {
                    await  viewModel.fetchMoreItems()
                }
            }).navigationBarTitle("Home", displayMode: .inline)
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(itemRepository: ItemStubService()))
            .environmentObject(RepositoryContainerFactory.createStubs())
    }
}
