//
//  SearchView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/20.
//

import SwiftUI
import SwiftUIX

struct SearchView: View {

    // MARK: - Property

    private let itemRepository: ItemRepository
    private let likeRepository: LikeRepository
    private let stockRepository: StockRepository
    @ObservedObject private var viewModel: SearchViewModel

    @State var isEditing: Bool = false
    @State private var searchText: String = ""

    @State private var isInitialOnAppear = true
    @State private var isPush: Bool = false

    // MARK: - Initializer

    init(tagRepository: TagRepository, itemRepository: ItemRepository, likeRepository: LikeRepository, stockRepository: StockRepository) {
        self.viewModel = SearchViewModel(tagRepository: tagRepository)
        self.itemRepository = itemRepository
        self.likeRepository = likeRepository
        self.stockRepository = stockRepository
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            VStack {
                TagListView(tags: viewModel.tags, itemRepository: itemRepository, likeRepository: likeRepository, stockRepository: stockRepository)

                NavigationLink(destination: SearchResultView(searchType: .word(searchText), itemRepository: itemRepository, likeRepository: likeRepository, stockRepository: stockRepository), isActive: $isPush) { EmptyView() }
                    .navigationBarTitle("Search", displayMode: .inline)
                    .navigationSearchBar {
                        SearchBar("キーワード検索", text: $searchText, isEditing: $isEditing, onCommit: { isPush.toggle() })
                            .showsCancelButton(isEditing)

                }
            }
        }.onAppear {
            if isInitialOnAppear {
                viewModel.fetchTags()
                isInitialOnAppear = false
            }
        }
    }
}

struct TagListView: View {

    let tags: [ItemTag]
    let itemRepository: ItemRepository
    let likeRepository: LikeRepository
    let stockRepository: StockRepository

    var body: some View {
        GeometryReader { geometry in
            CollectionView(tags) { tag in
                NavigationLink(destination: SearchResultView(searchType: .tag(tag), itemRepository: itemRepository, likeRepository: likeRepository, stockRepository: stockRepository)) {
                    ZStack {
                        ImageView(url: tag.iconUrl!)

                        Color(.darkText.withAlphaComponent(0.2))

                        Text(tag.id)
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .semibold))

                    }
                    // geometryが一瞬0.0等を返す場合があるので、その時に-にならないようにする
                    .frame(width: max(0.0, (geometry.size.width - 2) / 3), height: max(0.0, (geometry.size.width - 2) / 3))
                    // なんか1.0だとレイアウトが崩れる(小数演算の問題か)
                }
            }.collectionViewLayout(FlowCollectionViewLayout(minimumLineSpacing: 1, minimumInteritemSpacing: 0.99))
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(tagRepository: TagStubService(), itemRepository: ItemStubService(), likeRepository: LikeStubService(), stockRepository: StockStubService())
    }
}
