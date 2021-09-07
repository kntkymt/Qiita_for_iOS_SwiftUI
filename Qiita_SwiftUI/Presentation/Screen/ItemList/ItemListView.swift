//
//  ItemListView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import SwiftUI
import SwiftUIRefresh

struct ItemListView: View {

    // MARK: - Property

    @Binding var items: [Item]
    @Binding var isRefreshing: Bool

    let likeRepository: LikeRepository
    let stockRepository: StockRepository

    let onRefresh: () -> Void
    let onPaging: () -> Void

    // MARK: - Body

    var body: some View {
        List {
            ForEach(items) { item in
                ItemListItem(item: item, stockRepository: stockRepository, likeRepository: likeRepository)
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

    init(item: Item, stockRepository: StockRepository, likeRepository: LikeRepository) {
        self.viewModel = ItemListItemViewModel(item: item, stockRepository: stockRepository, likeRepository: likeRepository)
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
                        .frame(width: 44, height: 44)
                        .imageScale(.large)
                        .border(Color("brand"), width: 1, cornerRadius: 22)
                        .foregroundColor(Color.white)
                        .background(Color("brand"))
                        .cornerRadius(22)
                } else {
                    Image(systemName: .folder)
                        .onTapGesture { viewModel.stock() }
                        .frame(width: 44, height: 44)
                        .imageScale(.large)
                        .border(Color("brand"), width: 1, cornerRadius: 22)
                        .foregroundColor(Color("brand"))
                        .background(Color.clear)
                        .cornerRadius(22)
                }
            }.padding(.vertical, 8)
        }
    }
}

struct ItemListView_Previews: PreviewProvider {

    @State static var items: [Item] = ItemStubService.items
    @State static var isLoading = false

    static var previews: some View {
        ItemListView(items: $items, isRefreshing: $isLoading, likeRepository: LikeStubService(), stockRepository: StockStubService(), onRefresh: { }, onPaging: { })
    }
}
