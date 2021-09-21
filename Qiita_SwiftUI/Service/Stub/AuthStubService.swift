//
//  AuthStubService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

final class AuthStubService: AuthRepository {

    private let user = User(id: "kntkymt", name: "kntkymt", description: "iOSエンジニアです", profileImageUrl: URL(string: "https://avatars2.githubusercontent.com/u/44288050?v=4")!, itemsCount: 4, followeesCount: 3, followersCount: 3)

    private let authModel = AuthModel(clientId: "stub id", scopes: [], token: "stub token")

    var isSignedin: Bool = false

    func handleDeepLink(url: URL) {
        
    }

    func getCurrentUser() async throws -> User {
        return await withCheckedContinuation { $0.resume(returning: self.user) }
    }

    func signin() async throws -> AuthModel {
        return await withCheckedContinuation { $0.resume(returning: self.authModel) }
    }

    func signout() async throws -> Void {
        return await withCheckedContinuation { $0.resume(returning: ()) }
    }
}
