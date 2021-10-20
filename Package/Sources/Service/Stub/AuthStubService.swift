//
//  AuthStubService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation
import Repository
import Model

public final class AuthStubService: AuthRepository {

    // MARK: - Property

    private let user = User(id: "kntkymt", name: "kntkymt", description: "iOSエンジニアです", profileImageUrl: URL(string: "https://avatars2.githubusercontent.com/u/44288050?v=4")!, itemsCount: 4, followeesCount: 3, followersCount: 3)

    private let authModel = AuthModel(clientId: "stub id", scopes: [], token: "stub token")

    public var isSignedin: Bool = false

    // MARK: - Initializer

    public init() { }

    // MARK: - Public

    public func handleDeepLink(url: URL) {
        
    }

    public func getCurrentUser() async throws -> User {
        return await withCheckedContinuation { $0.resume(returning: self.user) }
    }

    public func signin() async throws -> AuthModel {
        return await withCheckedContinuation { $0.resume(returning: self.authModel) }
    }

    public func signout() async throws -> Void {
        return await withCheckedContinuation { $0.resume(returning: ()) }
    }
}
