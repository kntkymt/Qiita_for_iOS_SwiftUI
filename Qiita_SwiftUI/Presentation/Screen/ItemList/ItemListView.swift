//
//  ItemListView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import SwiftUI
import SwiftUIRefresh

struct ItemListView<HeaderView: View>: View {

    // MARK: - Property

    @Binding private var items: [Item]
    @Binding private var isRefreshing: Bool

    private let onItemStockChangedHandler: ((Item, Bool) -> Void)?

    private let likeRepository: LikeRepository
    private let stockRepository: StockRepository

    private let onRefresh: () -> Void
    private let onPaging: () -> Void

    private var headerView: HeaderView

    init(items: Binding<[Item]>, isRefreshing: Binding<Bool>, onItemStockChangedHandler: ((Item, Bool) -> Void)? = nil, likeRepository: LikeRepository, stockRepository: StockRepository, onRefresh: @escaping () -> Void, onPaging: @escaping () -> Void, @ViewBuilder header: () -> HeaderView) {
        self._items = items
        self._isRefreshing = isRefreshing
        self.onItemStockChangedHandler = onItemStockChangedHandler
        self.likeRepository = likeRepository
        self.stockRepository = stockRepository
        self.onRefresh = onRefresh
        self.onPaging = onPaging
        self.headerView = header()
    }

    // headerを使わない場合
    init(items: Binding<[Item]>, isRefreshing: Binding<Bool>, onItemStockChangedHandler: ((Item, Bool) -> Void)? = nil, likeRepository: LikeRepository, stockRepository: StockRepository, onRefresh: @escaping () -> Void, onPaging: @escaping () -> Void) where HeaderView == EmptyView {
        self._items = items
        self._isRefreshing = isRefreshing
        self.onItemStockChangedHandler = onItemStockChangedHandler
        self.likeRepository = likeRepository
        self.stockRepository = stockRepository
        self.onRefresh = onRefresh
        self.onPaging = onPaging
        self.headerView = EmptyView()
    }

    // MARK: - Body

    var body: some View {
        List {
            headerView

            ForEach(items) { item in
                ItemListItem(item: item, onItemStockChangedHandler: onItemStockChangedHandler, stockRepository: stockRepository, likeRepository: likeRepository)
            }

            HStack {
                Spacer()
                ProgressView()
                    .onAppear {
                        onPaging()
                    }
                Spacer()
            }
        }.listStyle(PlainListStyle())
        .pullToRefresh(isShowing: $isRefreshing, onRefresh: onRefresh)
    }
}

struct ItemListItem: View {

    @ObservedObject private var viewModel: ItemListItemViewModel

    // MARK: - Initializer

    init(item: Item, onItemStockChangedHandler: ((Item, Bool) -> Void)? = nil, stockRepository: StockRepository, likeRepository: LikeRepository) {
        self.viewModel = ItemListItemViewModel(item: item, onItemStockChangedHandler: onItemStockChangedHandler, stockRepository: stockRepository, likeRepository: likeRepository)

        // FIXME: ここだけ例外的にonAppearではなくinitでやってる
        // 1回だけのonAppearでやると、onAppearの後にListの更新がなぜか走り、checkしたステータスが初期化されてしまう
        viewModel.checkIsStocked()
    }

    var body: some View {
        NavigationLink(destination: ItemDetailView(item: viewModel.item, likeRepository: viewModel.likeRepository, stockRepository: viewModel.stockRepository)) {
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
                        .onTapGesture { viewModel.unStock() }
                        .frame(width: 32, height: 32)
                        .imageScale(.medium)
                        .border(Color("brand"), width: 1, cornerRadius: 22)
                        .foregroundColor(Color.white)
                        .background(Color("brand"))
                        .cornerRadius(16)
                } else {
                    Image(systemName: .folder)
                        .onTapGesture { viewModel.stock() }
                        .frame(width: 32, height: 32)
                        .imageScale(.medium)
                        .border(Color("brand"), width: 1, cornerRadius: 22)
                        .foregroundColor(Color("brand"))
                        .background(Color.clear)
                        .cornerRadius(16)
                }
            }.padding(.vertical, 8)
        }
    }
}

struct ItemListView_Previews: PreviewProvider {

    @State static var items: [Item] = ItemStubService.items
    @State static var isLoading = false

    static var previews: some View {
        ItemListView(items: $items, isRefreshing: $isLoading, onItemStockChangedHandler: nil, likeRepository: LikeStubService(), stockRepository: StockStubService(), onRefresh: { }, onPaging: { })
    }
}
