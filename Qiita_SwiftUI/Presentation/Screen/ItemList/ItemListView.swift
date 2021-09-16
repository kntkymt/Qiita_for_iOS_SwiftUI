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

    @EnvironmentObject var repositoryContainer: RepositoryContainer

    private let items: [Item]
    @Binding private var isRefreshing: Bool

    private let onItemStockChangedHandler: ((Item, Bool) -> Void)?

    private let onRefresh: () -> Void
    private let onPaging: () -> Void

    private var headerView: HeaderView

    // MARK: - Initializer

    init(items: [Item], isRefreshing: Binding<Bool>, onItemStockChangedHandler: ((Item, Bool) -> Void)? = nil, onRefresh: @escaping () -> Void, onPaging: @escaping () -> Void, @ViewBuilder header: () -> HeaderView) {
        self.items = items
        self._isRefreshing = isRefreshing
        self.onItemStockChangedHandler = onItemStockChangedHandler
        self.onRefresh = onRefresh
        self.onPaging = onPaging
        self.headerView = header()
    }

    // headerを使わない場合
    init(items: [Item], isRefreshing: Binding<Bool>, onItemStockChangedHandler: ((Item, Bool) -> Void)? = nil, onRefresh: @escaping () -> Void, onPaging: @escaping () -> Void) where HeaderView == EmptyView {
        self.items = items
        self._isRefreshing = isRefreshing
        self.onItemStockChangedHandler = onItemStockChangedHandler
        self.onRefresh = onRefresh
        self.onPaging = onPaging
        self.headerView = EmptyView()
    }

    // MARK: - Body

    var body: some View {
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
        .pullToRefresh(isShowing: $isRefreshing, onRefresh: onRefresh)
        .footerLoading { onPaging() }
    }
}

struct ItemListItem: View {

    // MARK: - Property

    @EnvironmentObject var repositoryContainer: RepositoryContainer
    @ObservedObject private var viewModel: ItemListItemViewModel

    // MARK: - Initializer

    init(viewModel: ItemListItemViewModel) {
        self.viewModel = viewModel

        // FIXME: ここだけ例外的にonAppearではなくinitでやってる
        // 1回だけのonAppearでやると、onAppearの後にListの更新がなぜか走り、checkしたステータスが初期化されてしまう
        viewModel.checkIsStocked()
    }

    // MARK: - Body

    var body: some View {
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

    static let items: [Item] = ItemStubService.items
    @State static var isLoading = false

    static var previews: some View {
        ItemListView(items: items, isRefreshing: $isLoading, onItemStockChangedHandler: nil, onRefresh: { }, onPaging: { })
            .environmentObject(RepositoryContainerFactory.createStubs())
    }
}
