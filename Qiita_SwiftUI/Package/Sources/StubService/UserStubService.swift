//
//  UserStubService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/09/13.
//

import Foundation
import Repository
import Model

public final class UserStubService: UserRepository {

    // MARK: - Property

    let user = User(id: "kntkymt", name: "kntkymt", description: "iOSエンジニアです", profileImageUrl: URL(string: "https://avatars2.githubusercontent.com/u/44288050?v=4")!, itemsCount: 10, followeesCount: 20, followersCount: 30)

    // MARK: - Initializer

    public init() { }

    // MARK: - Public

    public func getUser(id: User.ID) async throws -> User {
        return await withCheckedContinuation { $0.resume(returning: self.user) }
    }
}
