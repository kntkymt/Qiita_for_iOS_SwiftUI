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

    @EnvironmentObject var repositoryContainer: RepositoryContainer
    @ObservedObject private var viewModel: SearchViewModel

    @State var isEditing: Bool = false
    @State private var searchText: String = ""

    @State private var isInitialOnAppear = true
    @State private var isPush: Bool = false

    // MARK: - Initializer

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                NavigationLink(destination: SearchResultView(viewModel: SearchResultViewModel(searchType: .word(searchText), itemRepository: repositoryContainer.itemRepository)), isActive: $isPush) { EmptyView() }

                // ヘッダーも含めてスクロールさせたいが
                // ListやCollectionViewのヘッダーが存在しないので
                // ScrollViewで囲い、中のCollectionViewの高さを固定長(スクロールなし)にして実装する
                ScrollView {

                    HStack {
                        Text("キーワード検索")
                            .padding(.leading, 4)
                        Spacer()
                    }

                    KeywordListView(keywords: ["Firebase", "ARKit", "GitHub", "iPadOS", "ライブラリ", "iOS15", "SwiftUI", "MacOS"]) { keyword in
                        searchText = keyword
                        isPush = true
                    }.height(100)

                    HStack {
                        Text("タグ検索")
                            .padding(.leading, 4)
                        Spacer()
                    }

                    TagListView(tags: viewModel.tags)
                        // scrollDisableが反応しないのでcontent以上の高さにしてスクロールできなくする
                        .height((geometry.size.width / 3) * 10 + 5)
                }
            }
            .navigationBarTitle("Search", displayMode: .inline)
            .navigationSearchBar {
                SearchBar("キーワード検索", text: $searchText, isEditing: $isEditing, onCommit: { isPush.toggle() })
                    .showsCancelButton(isEditing)

            }
            .onAppear {
                if isInitialOnAppear {
                    viewModel.fetchTags()
                    isInitialOnAppear = false
                }

                searchText = ""
            }
        }
    }
}

struct KeywordListView: View {

    // MARK: - Property

    let keywords: [String]
    let onKeywordTapHandler: ((String) -> Void)?

    // MARK: - Body

    var body: some View {
        CollectionView(keywords, id: \.hashValue) { keyword in
            // boderの前と後で.paddingの効果が変わる
            // 前はinner padding, 後はouter padding(margin)
            Button(keyword) { onKeywordTapHandler?(keyword) }
                .padding(.horizontal, 2)
                .padding(.vertical, 2)
                .border(Color("brand"), width: 1, cornerRadius: 22)
                .padding(.horizontal, 2)
                .padding(.vertical, 3)
                .foregroundColor(Color("brand"))
                .background(Color.clear)
                .cornerRadius(22)
        }.collectionViewLayout(FlowCollectionViewLayout())
        .padding(.horizontal, 2)
    }
}

struct TagListView: View {

    @EnvironmentObject var repositoryContainer: RepositoryContainer

    let tags: [ItemTag]

    var body: some View {
        GeometryReader { geometry in
            CollectionView(tags) { tag in
                NavigationLink(destination: SearchResultView(viewModel: SearchResultViewModel(searchType: .tag(tag), itemRepository: repositoryContainer.itemRepository))) {
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
            }
            .collectionViewLayout(FlowCollectionViewLayout(minimumLineSpacing: 1, minimumInteritemSpacing: 0.99))
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel(tagRepository: TagStubService()))
    }
}
