//
//  AuthService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation
import Repository
import Model
import Network

public final class AuthService: AuthRepository {

    public init() { }

    public var isSignedin: Bool {
        return Auth.shared.isSignedin
    }

    public func handleDeepLink(url: URL) {
        Auth.shared.handleDeepLink(url: url)
    }

    public func getCurrentUser() async throws -> User {
        return try await Auth.shared.getCurrentUser()
    }

    public func signin() async throws -> AuthModel {
        return try await Auth.shared.signin()
    }

    public func signout() async throws -> Void {
        return try await Auth.shared.signout()
    }
}
