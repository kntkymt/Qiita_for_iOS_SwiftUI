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
        NavigationLink(destination: ItemDetailView(item: item)) {
            HStack {
                ImageView(url: item.user.profileImageUrl)
                    .frame(width: 40, height: 40)
                    .cornerRadius(4.0)

                VStack(alignment: .leading, spacing: 6) {
                    Text(item.title)
                        .font(.system(size: 14, weight: .medium))

                    HStack {
                        Text("@\(item.user.id)")
                            .foregroundColor(.secondary)
                            .font(.system(size: 12))

                        Image(systemName: "hand.thumbsup")
                            .frame(width: 4, height: 12)
                            .font(.system(size: 12))

                        Text(item.likesCount.description)
                            .foregroundColor(.secondary)
                            .font(.system(size: 12))
                    }
                }
            }.padding(.vertical, 8)
        }
    }
}

struct ItemListView_Previews: PreviewProvider {

    @State static var items: [Item] = ItemStubService.items

    static var previews: some View {
        ItemListView(items: $items)
    }
}
