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

    private let items: [Item]

    private let onItemStockChangedHandler: ((Item, Bool) -> Void)?

    private let onRefresh: () async -> Void
    private let onPaging: () async -> Void

    private var headerView: HeaderView

    // MARK: - Initializer

    init(items: [Item], onItemStockChangedHandler: ((Item, Bool) -> Void)? = nil, onRefresh: @escaping () async -> Void, onPaging: @escaping () async -> Void, @ViewBuilder header: () -> HeaderView) {
        self.items = items
        self.onItemStockChangedHandler = onItemStockChangedHandler
        self.onRefresh = onRefresh
        self.onPaging = onPaging
        self.headerView = header()
    }

    // headerを使わない場合
    init(items: [Item], onItemStockChangedHandler: ((Item, Bool) -> Void)? = nil, onRefresh: @escaping () async -> Void, onPaging: @escaping () async -> Void) where HeaderView == EmptyView {
        self.items = items
        self.onItemStockChangedHandler = onItemStockChangedHandler
        self.onRefresh = onRefresh
        self.onPaging = onPaging
        self.headerView = EmptyView()
    }

    // MARK: - Body

    public var body: some View {
        List {
            /// FIXME: 左寄せになっている問題
            /// GeometryReaderやSpacer()を使えば中心寄せにできるが
            /// それをするとEmptyViewの場合でも高さを持ってしまい、ヘッダーに空白が出来てしまう
            /// 現在はSearchResultの方で幅を指定して対応
            headerView

            ForEach(items) { item in
                ItemListItem(viewModel: ItemListItemViewModel(item: item, onItemStockChangedHandler: onItemStockChangedHandler, stockRepository: repositoryContainer.stockRepository, likeRepository: repositoryContainer.likeRepository))
            }
        }
        .listStyle(PlainListStyle())
        .refreshable { await onRefresh() }
        .moreLoadable { await onPaging() }
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
