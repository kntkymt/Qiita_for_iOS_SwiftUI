//
//  TagInformationView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/09/13.
//

import SwiftUI

struct TagInformationView: View {

    // MARK: - Property

    @EnvironmentObject var repositoryContainer: RepositoryContainer

    @ObservedObject private var viewModel: TagInformationViewModel
    @State private var isInitialOnAppear = true

    // MARK: - Initializer

    init(viewModel: TagInformationViewModel) {
        self.viewModel = viewModel

        /// FIXME: ItemListItemと同様にonAppearでやると再描画されて状態が上書きされる
        viewModel.checkIsFollowed()
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            ImageView(url: viewModel.tag.iconUrl!)
                .frame(width: 150, height: 150)

            Text(viewModel.tag.id)
                .font(.system(size: 20, weight: .medium))

            HStack(spacing: 32) {
                ContributionView(title: "記事", count: viewModel.tag.itemsCount)
                ContributionView(title: "フォロワー", count: viewModel.tag.followersCount)
            }

            if viewModel.isFollowed {
                Text("フォロー中")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .border(Color("brand"), width: 1)
                    .foregroundColor(Color.white)
                    .background(Color("brand"))
                    .frame(width: 150, height: 30)
                    .onTapGesture { viewModel.unfollow() }
            } else {
                Text("フォローする")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .border(Color("brand"), width: 1)
                    .foregroundColor(Color("brand"))
                    .background(Color.clear)
                    .frame(width: 150, height: 30)
                    .onTapGesture { viewModel.follow() }
            }
        }
    }
}
