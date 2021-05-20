//
//  ProfileView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/20.
//

import SwiftUI

struct ProfileView: View {

    // MARK: - Property

    @ObservedObject private var viewModel: ProfileViewModel

    // MARK: - Initializer

    init(authRepository: AuthRepository, itemRepository: ItemRepository) {
        self.viewModel = ProfileViewModel(authRepository: authRepository, itemRepository: itemRepository)
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            Group {
                if let user = viewModel.user {
                    VStack(spacing: 0) {
                        UserInformationView(user: user)

                        ItemListView(items: $viewModel.items)
                    }
                } else {
                    ProgressView()
                }
            }.navigationBarTitle("Profile", displayMode: .inline)
        }
    }
}

struct UserInformationView: View {

    // MARK: - Property

    var user: User

    // MARK: - Body

    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 4) {
                ImageView(url: user.profileImageUrl)
                    .frame(width: 100, height: 100)
                    .cornerRadius(4.0)

                Text(user.name)
                    .font(.system(size: 20, weight: .medium))

                Text("@\(user.id)")
                    .font(.system(size: 17))
                    .foregroundColor(.secondary)

                Text(user.description ?? " ")
            }

            VStack(spacing: 2) {
                HStack(spacing: 0) {
                    UserContributionView(title: "投稿", count: user.itemsCount)
                    UserContributionView(title: "フォロー", count: user.followeesCount)
                    UserContributionView(title: "フォロワー", count: user.followersCount)
                }

                Divider()
            }
        }
    }
}

struct UserContributionView: View {

    // MARK: - Property

    var title: String
    var count: Int

    // MARK: - Body

    var body: some View {
        VStack(spacing: 8) {
            Text(count.description)
                .font(.system(size: 16, weight: .medium))

            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.secondary)
        }.frame(width: 100, height: 60)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(authRepository: AuthStubService(), itemRepository: ItemStubService())
    }
}
