//
//  AuthService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

final class AuthService: AuthRepository {

    var isSignedin: Bool {
        return Auth.shared.isSignedin
    }

    func handleDeepLink(url: URL) {
        Auth.shared.handleDeepLink(url: url)
    }

    func getCurrentUser() async throws -> User {
        return try await Auth.shared.getCurrentUser()
    }

    func signin() async throws -> AuthModel {
        return try await Auth.shared.signin()
    }

    func signout() async throws -> Void {
        return try await Auth.shared.signout()
    }
}
