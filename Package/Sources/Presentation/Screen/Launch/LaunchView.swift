//
//  LaunchView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import SwiftUI
import Environment

public struct LaunchView: View {

    // MARK: - Property

    @EnvironmentObject var repositoryContainer: RepositoryContainer
    @EnvironmentObject var authState: AuthState

    // MARK: - Initializer

    public init() { }

    // MARK: - Body

    public var body: some View {
        if authState.isSignedin {
            MainView()
        } else {
            LoginView(viewModel: LoginViewModel(authRepository: repositoryContainer.authRepository))
        }
    }
}

//struct LaunchView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchView()
//            .environmentObject(RepositoryContainerFactory.createStubs())
//            .environmentObject(AuthState(authRepository: AuthStubService()))
//    }
//}
