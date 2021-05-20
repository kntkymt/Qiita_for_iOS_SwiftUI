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
    @ObservedObject private var viewModel: SearchViewModel

    @State var isEditing: Bool = false
    @State private var searchText: String = ""

    @State private var isPush: Bool = false

    // MARK: - Initializer

    init(tagRepository: TagRepository, itemRepository: ItemRepository) {
        self.viewModel = SearchViewModel(tagRepository: tagRepository)
        self.itemRepository = itemRepository
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.tags) { tag in
                        Text(tag.id)
                    }
                }
                NavigationLink(destination: SearchResultView(searchWord: searchText, itemRepository: itemRepository), isActive: $isPush) { EmptyView() }
                    .navigationBarTitle("Search", displayMode: .inline)
                    .navigationSearchBar {
                        SearchBar("キーワード検索", text: $searchText, isEditing: $isEditing, onCommit: { isPush.toggle() })
                            .showsCancelButton(isEditing)

                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(tagRepository: TagStubService(), itemRepository: ItemStubService())
    }
}
