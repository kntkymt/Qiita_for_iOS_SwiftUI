//
//  SearchView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/20.
//

import SwiftUI

struct SearchView: View {

    // MARK: - Property

    @ObservedObject private var viewModel: SearchViewModel

    @State private var seachText: String = ""

    // MARK: - Initializer

    init(tagRepository: TagRepository) {
        self.viewModel = SearchViewModel(tagRepository: tagRepository)
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tags) { tag in
                    Text(tag.id)
                }
            }.navigationBarItems(leading: TextField("キーワード検索", text: $seachText), trailing: Button("キャンセル", action: { }))
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(tagRepository: TagStubService())
    }
}
