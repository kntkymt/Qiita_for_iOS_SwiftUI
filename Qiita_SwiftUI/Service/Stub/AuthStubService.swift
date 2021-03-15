//
//  AuthStubService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Combine
import Foundation

final class AuthStubService: AuthRepository {

    private let user = User(id: "1111",
                            name: "hoge",
                            description: "hogeです。\nよろしくお願いします。",
                            profileImageUrl: URL(string: "https://avatars.githubusercontent.com/u/44288050?s=400&u=57fbf71e9e2e411af3da17f82051cf83cdb0df56&v=4")!,
                            itemsCount: 2,
                            followeesCount: 3,
                            followersCount: 4)

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
