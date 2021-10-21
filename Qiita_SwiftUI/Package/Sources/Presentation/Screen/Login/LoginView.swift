//
//  LoginView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import SwiftUI
import Common

public struct LoginView: View {

    // MARK: - Property

    @EnvironmentObject var authState: AuthState
    @State private var isPresented = false

    @StateObject private var viewModel: LoginViewModel

    // MARK: - Initializer

    init(viewModel: LoginViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - Body

    public var body: some View {
        Button("Login") {
            isPresented = true
            Task {
                await viewModel.login() {
                    authState.isSignedin = true
                    isPresented = false
                }
            }
        }.sheet(isPresented: $isPresented, content: {
            SafariView(url: AppConstant.shared.auth.signinURL)
        }).onOpenURL { url in
            Logger.debug("DeepLink: \(url)")
            viewModel.handleDeepLink(url: url)
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(viewModel: LoginViewModel(authRepository: AuthStubService()))
//            .environmentObject(RepositoryContainerFactory.createStubs())
//            .environmentObject(AuthState(authRepository: AuthStubService()))
//    }
//}
