//
//  ItemListView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import SwiftUI
import Model

public struct ItemListView<HeaderView: View>: View {

    // MARK: - Property

    @EnvironmentObject var repositoryContainer: RepositoryContainer

    @State private var isInitialOnAppear = true
    @State private var isInitialLoading = true

    private let items: [Item]

    private let onItemStock: ((_ item: Item, _ status: Bool) -> Void)?

    private let onInit: () async -> Void
    private let onRefresh: () async -> Void
    private let onPaging: () async -> Void

    private let emptyTitle: String
    private var headerView: HeaderView

    // MARK: - Initializer

    init(items: [Item], emptyTitle: String, onItemStock: ((_ item: Item, _ status: Bool) -> Void)? = nil, onInit: @escaping () async -> Void, onRefresh: @escaping () async -> Void, onPaging: @escaping () async -> Void, @ViewBuilder header: () -> HeaderView) {
        self.items = items
        self.emptyTitle = emptyTitle
        self.onItemStock = onItemStock
        self.onInit = onInit
        self.onRefresh = onRefresh
        self.onPaging = onPaging
        self.headerView = header()
    }

    // headerを使わない場合
    init(items: [Item], emptyTitle: String, onItemStock: ((_ item: Item, _ status: Bool) -> Void)? = nil, onInit: @escaping () async -> Void, onRefresh: @escaping () async -> Void, onPaging: @escaping () async -> Void) where HeaderView == EmptyView {
        self.items = items
        self.emptyTitle = emptyTitle
        self.onItemStock = onItemStock
        self.onInit = onInit
        self.onRefresh = onRefresh
        self.onPaging = onPaging
        self.headerView = EmptyView()
    }

    // MARK: - Body

    public var body: some View {
        GeometryReader { reader in
            List {
                headerView
                    .frame(maxWidth: .infinity)

                if isInitialLoading {
                    ProgressView()
                        .scaleEffect(x: 2, y: 2, anchor: .center)
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity)
                        .frame(height: reader.size.height)
                } else if items.isEmpty {
                    EmptyContentView(title: emptyTitle)
                        .frame(maxWidth: .infinity)
                        .frame(height: reader.size.height)
                } else {
                    ForEach(items) { item in
                        ItemListItem(viewModel: ItemListItemViewModel(item: item, onItemStock: onItemStock, stockRepository: repositoryContainer.stockRepository, likeRepository: repositoryContainer.likeRepository))
                    }
                }
            }
            .listStyle(PlainListStyle())
            .refreshable { await onRefresh() }
            .moreLoadable { await onPaging() }
            .onAppear {
                if isInitialOnAppear {
                    Task {
                        isInitialLoading = true
                        await onInit()
                        isInitialLoading = false
                    }

                    isInitialOnAppear = false
                }
            }
        }
    }
}

public struct ItemListItem: View {

    // MARK: - Property

    @EnvironmentObject var repositoryContainer: RepositoryContainer
    @StateObject private var viewModel: ItemListItemViewModel

    @State private var isInitialOnAppear = true

    // MARK: - Initializer

    init(viewModel: ItemListItemViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - Body

    public var body: some View {
        NavigationLink(destination: ItemDetailView(viewModel: ItemDetailViewModel(item: viewModel.item, likeRepository: repositoryContainer.likeRepository, stockRepository: repositoryContainer.stockRepository))) {
            HStack {
                ImageView(url: viewModel.item.user.profileImageUrl)
                    .frame(width: 40, height: 40)
                    .cornerRadius(4.0)

                VStack(alignment: .leading, spacing: 6) {
                    Text(viewModel.item.title)
                        .font(.system(size: 14, weight: .medium))

                    HStack {
                        Text("@\(viewModel.item.user.id)")
                            .foregroundColor(.secondary)
                            .font(.system(size: 12))

                        Image(systemName: "hand.thumbsup")
                            .frame(width: 4, height: 12)
                            .font(.system(size: 12))

                        Text(viewModel.item.likesCount.description)
                            .foregroundColor(.secondary)
                            .font(.system(size: 12))
                    }
                }

                Spacer()

                // NavigationLinkの上にButtonは置けないので
                // Image.onTapGesture
                if viewModel.isStocked {
                    Image(systemName: .folderFill)
                        .onTapGesture {
                            Task {
                                await viewModel.unStock()
                            }
                        }
                        .frame(width: 32, height: 32)
                        .imageScale(.medium)
                        .border(Color("brand"), width: 1, cornerRadius: 22)
                        .foregroundColor(Color.white)
                        .background(Color("brand"))
                        .cornerRadius(16)
                } else {
                    Image(systemName: .folder)
                        .onTapGesture {
                            Task {
                                await viewModel.stock()
                            }
                        }
                        .frame(width: 32, height: 32)
                        .imageScale(.medium)
                        .border(Color("brand"), width: 1, cornerRadius: 22)
                        .foregroundColor(Color("brand"))
                        .background(Color.clear)
                        .cornerRadius(16)
                }
            }.padding(.vertical, 8)
        }.onAppear {
            if isInitialOnAppear {
                Task {
                    await viewModel.checkIsStocked()
                }
                isInitialOnAppear = false
            }
        }
    }
}
//
//struct ItemListView_Previews: PreviewProvider {
//
//    static let items: [Item] = ItemStubService.items
//
//    static var previews: some View {
//        ItemListView(items: items, onItemStockChangedHandler: nil, onRefresh: { }, onPaging: { })
//            .environmentObject(RepositoryContainerFactory.createStubs())
//    }
//}
