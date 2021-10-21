//
//  Auth.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation
import Common
import Model

public final class Auth {

    // MARK: - Static

    public static let shared = Auth()

    // MARK: - Property

    private var continuation: CheckedContinuation<AuthModel, Error>!

    @KeyChain(key: "accessToken")
    var accessToken: String?

    public var isSignedin: Bool {
        return accessToken != nil
    }

    // MARK: - Public

    public func handleDeepLink(url: URL) {
        let parameters = url.queryParameters
        guard let code = parameters["code"] else {
            continuation.resume(throwing: AuthError.deeplink)
            return
        }

        Task {
            do {
                let authModel = try await API.shared.call(AuthTarget.getAccessToken(code: code)) as AuthModel
                self.accessToken = authModel.token
                continuation.resume(returning: authModel)
            } catch {
                continuation.resume(throwing: AuthError.response(error))
            }
        }
    }

    public func getCurrentUser() async throws -> User {
        return try await API.shared.call(AuthTarget.getAccount)
    }

    public func signin() async throws -> AuthModel {
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
        }
    }

    public func signout() async throws -> Void {
        _ = try await API.shared.call(AuthTarget.deleteAccessToken(accessToken: accessToken ?? "accessToken not found")) as VoidModel
        accessToken = nil
    }

    // MARK: - Initializer

    private init() {
    }
}
