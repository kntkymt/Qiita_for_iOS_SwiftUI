//
//  ImageView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import SwiftUI

struct ImageView: View {

    // MARK: - Property

    var url: URL

    // MARK: - Public

    var body: some View {
        ZStack {
            AsyncImage(url: url, content: { image in
                Rectangle().fill(Color.systemBackground)
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            }, placeholder: {
                Rectangle().fill(Color.systemGray)
            })
        }
    }
}
