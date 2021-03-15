//
//  AuthService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Combine
import Foundation

final class AuthService: AuthRepository {

    var isSignedin: Bool {
        return Auth.shared.isSignedin
    }

    func handleDeepLink(url: URL) {
        Auth.shared.handleDeepLink(url: url)
    }

    func getCurrentUser() -> AnyPublisher<User, Error> {
        return Auth.shared.currentUser
    }

    func signin() -> AnyPublisher<AuthModel, Error> {
        return Auth.shared.signin()
    }

    func signout() -> AnyPublisher<Void, Error> {
        return Auth.shared.signout()
    }
}
