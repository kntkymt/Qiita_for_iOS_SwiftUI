//
//  ItemDetailView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import SwiftUI

struct ItemDetailView: View {

    // MARK: - Property

    var item: Item

    // MARK: - Body

    var body: some View {
        WebView(url: item.url)
            .navigationTitle(item.title)
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(item: Item(title: "Hello Wordl", id: "1", url: URL(string: "https://qiita.com/api/v2/docs")!, likesCount: 0, createdAt: Date(), user: User(id: "1", name: "hoge", description: "", profileImageUrl: URL(string: "https://qiita.com/api/v2/docs")!, itemsCount: 0, followeesCount: 0, followersCount: 0)))
    }
}
