//
//  AuthStubService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Combine
import Foundation

final class AuthStubService: AuthRepository {

    private let user = User(id: "kntkymt", name: "kntkymt", description: "iOSエンジニアです", profileImageUrl: URL(string: "https://avatars2.githubusercontent.com/u/44288050?v=4")!, itemsCount: 4, followeesCount: 3, followersCount: 3)

    private let authModel = AuthModel(clientId: "stub id", scopes: [], token: "stub token")

    var isSignedin: Bool = false

    func handleDeepLink(url: URL) {
        
    }

    func getCurrentUser() -> AnyPublisher<User, Error> {
        return Future { $0(.success(self.user)) }.eraseToAnyPublisher()
    }

    func signin() -> AnyPublisher<AuthModel, Error> {
        return Future { $0(.success(self.authModel)) }.eraseToAnyPublisher()
    }

    func signout() -> AnyPublisher<Void, Error> {
        return Future { $0(.success(())) }.eraseToAnyPublisher()
    }
}
