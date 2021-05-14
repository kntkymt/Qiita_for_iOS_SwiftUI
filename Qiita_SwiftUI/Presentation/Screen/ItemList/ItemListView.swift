//
//  ItemListView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import SwiftUI

struct ItemListView: View {

    // MARK: - Property

    @Binding var items: [Item]

    // MARK: - Body

    var body: some View {
        List {
            ForEach(items) { item in
                ItemListItem(item: item)
            }
        }.listStyle(PlainListStyle())
    }
}

struct ItemListItem: View {

    var item: Item

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.title)
        }
    }
}

struct ItemListView_Previews: PreviewProvider {

    @State static var items: [Item] = .init(repeating: Item(title: "Hello Wordl", id: "1", url: URL(string: "https://qiita.com/api/v2/docs")!, likesCount: 0, createdAt: Date(), user: User(id: "1", name: "hoge", description: "", profileImageUrl: URL(string: "https://qiita.com/api/v2/docs")!, itemsCount: 0, followeesCount: 0, followersCount: 0)), count: 10)

    static var previews: some View {
        ItemListView(items: $items)
    }
}