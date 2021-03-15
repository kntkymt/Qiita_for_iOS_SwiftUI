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

    @ObservedObject private var viewModel: LoginViewModel

    // MARK: - Initializer

    init(authRepository: AuthRepository) {
        viewModel = LoginViewModel(authRepository: authRepository)
    }

    // MARK: - Body

    var body: some View {
        Button("Login") {
            viewModel.login() {
                authState.isSignedin = true
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authRepository: AuthStubService())
    }
}
