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

    let authRepository: AuthRepository
    let itemRepository: ItemRepository

    // MARK: - Body

    var body: some View {
        if authState.isSignedin {
            MainView(itemRepository: itemRepository)
        } else {
            LoginView(authRepository: authRepository)
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(authRepository: AuthStubService(), itemRepository: ItemStubService())
            .environmentObject(AuthState(authRepository: AuthStubService()))
    }
}

