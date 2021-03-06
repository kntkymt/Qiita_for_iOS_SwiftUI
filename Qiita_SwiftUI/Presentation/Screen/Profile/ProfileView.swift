//
//  ProfileView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/20.
//

import SwiftUI

struct ProfileView: View {

    // MARK: - Property

    @EnvironmentObject var repositoryContainer: RepositoryContainer

    @StateObject private var viewModel: ProfileViewModel
    @State private var isPresented = false
    @State private var isInitialOnAppear = true

    // MARK: - Initializer

    init(viewModel: ProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            Group {
                if let user = viewModel.user {
                    VStack(spacing: 0) {
                        UserInformationView(user: user)

                        ItemListView(items: viewModel.items, onItemStockChangedHandler: nil, onRefresh: {
                            await viewModel.fetchItems()
                        }, onPaging: {
                            await viewModel.fetchMoreItems()
                        })
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationBarTitle("Profile", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: { isPresented.toggle() }) {
                Image(systemName: "gear")
                    .renderingMode(.template)
                    .foregroundColor(Color("brand"))
            })
        }.onAppear {
            if isInitialOnAppear {
                Task {
                    await (viewModel.fetchUser(), viewModel.fetchItems())
                }

                isInitialOnAppear = false
            }
        }
        .sheet(isPresented: $isPresented) {
            SettingView(isPresenting: $isPresented, viewModel: SettingViewModel(authRepository: repositoryContainer.authRepository))
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
                    ContributionView(title: "??????", count: user.itemsCount)
                    ContributionView(title: "????????????", count: user.followeesCount)
                    ContributionView(title: "???????????????", count: user.followersCount)
                }

                Divider()
            }
        }
    }
}

struct ContributionView: View {

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
        ProfileView(viewModel: ProfileViewModel(authRepository: AuthStubService(), itemRepository: ItemStubService()))
            .environmentObject(RepositoryContainerFactory.createStubs())
            .environmentObject(AuthState(authRepository: AuthStubService()))
    }
}
