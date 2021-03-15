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

    let authRepository: AuthRepository

    // MARK: - Body

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authRepository: AuthStubService())
    }
}
