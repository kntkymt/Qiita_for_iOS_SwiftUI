//
//  HomeView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/14.
//

import SwiftUI

public struct HomeView: View {

    // MARK: - Property

    @EnvironmentObject var repositoryContainer: RepositoryContainer

    @StateObject private var viewModel: HomeViewModel

    @State private var isInitialOnAppear = true


    // MARK: - Initializer

    init(viewModel: HomeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - Body

    public var body: some View {
        NavigationView {
            ItemListView(items: viewModel.items, onItemStockChangedHandler: nil, onRefresh: {
                await viewModel.fetchItems()
            }, onPaging: {
                await  viewModel.fetchMoreItems()
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

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(viewModel: HomeViewModel(itemRepository: ItemStubService()))
//            .environmentObject(RepositoryContainerFactory.createStubs())
//    }
//}
