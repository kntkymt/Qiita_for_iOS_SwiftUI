//
//  LaunchView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import SwiftUI

struct LaunchView: View {

    // MARK: - Property

    @EnvironmentObject var authState: AuthState

    let likeRepository: LikeRepository
    let authRepository: AuthRepository
    let itemRepository: ItemRepository
    let stockRepository: StockRepository
    let tagRepository: TagRepository

    // MARK: - Body

    var body: some View {
        if authState.isSignedin {
            MainView(likeRepository: likeRepository, authRepository: authRepository, itemRepository: itemRepository, stockRepository: stockRepository, tagRepository: tagRepository)
        } else {
            LoginView(authRepository: authRepository)
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(likeRepository: LikeStubService(), authRepository: AuthStubService(), itemRepository: ItemStubService(), stockRepository: StockStubService(), tagRepository: TagStubService())
            .environmentObject(AuthState(authRepository: AuthStubService()))
    }
}

