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

    // MARK: - Body

    var body: some View {
        if authState.isSignedin {
            MainView()
        } else {
            LoginView(authRepository: authRepository)
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(authRepository: AuthStubService())
            .environmentObject(AuthState(authRepository: AuthStubService()))
    }
}

