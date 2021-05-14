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
        ItemDetailView(item: ItemStubService.items[0])
    }
}
