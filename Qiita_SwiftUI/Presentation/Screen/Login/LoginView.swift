//
//  LoginView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import SwiftUI

struct LoginView: View {

    // MARK: - Property

    @EnvironmentObject var authState: AuthState
    @State private var isPresented = false

    @ObservedObject private var viewModel: LoginViewModel

    // MARK: - Initializer

    init(authRepository: AuthRepository) {
        viewModel = LoginViewModel(authRepository: authRepository)
    }

    // MARK: - Body

    var body: some View {
        Button("Login") {
            isPresented = true
            viewModel.login() {
                authState.isSignedin = true
                isPresented = false
            }
        }.sheet(isPresented: $isPresented, content: {
            SafariView(url: AppConstant.Auth.signinURL)
        }).onOpenURL { url in
            Logger.debug("DeepLink: \(url)")
            viewModel.handleDeepLink(url: url)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authRepository: AuthStubService())
    }
}
