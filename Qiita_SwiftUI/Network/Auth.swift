//
//  Auth.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

final class Auth {

    // MARK: - Static

    static let shared = Auth()

    // MARK: - Property

    private var continuation: CheckedContinuation<AuthModel, Error>!

    @KeyChain(key: "accessToken")
    var accessToken: String?

    var isSignedin: Bool {
        return accessToken != nil
    }

    // MARK: - Public

    func handleDeepLink(url: URL) {
        let parameters = url.queryParameters
        guard let code = parameters["code"] else {
            continuation.resume(throwing: NetworkingError.internal(message: "there is no parameter named code in this deeplink"))
            return
        }

        Task {
            do {
                let authModel = try await API.shared.call(AuthTarget.getAccessToken(code: code)) as AuthModel
                self.accessToken = authModel.token
                continuation.resume(returning: authModel)
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }

    func getCurrentUser() async throws -> User {
        return try await API.shared.call(AuthTarget.getAccount)
    }

    func signin() async throws -> AuthModel {
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
        }
    }

    func signout() async throws -> Void {
        _ = try await API.shared.call(AuthTarget.deleteAccessToken(accessToken: accessToken ?? "accessToken not found")) as VoidModel
        accessToken = nil
    }

    // MARK: - Initializer

    private init() {
    }
}
