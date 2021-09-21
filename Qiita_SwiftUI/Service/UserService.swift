//
//  UserService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Combine

final class UserService: UserRepository {

    func getUser(id: User.ID) async throws -> User {
        return try await API.shared.call(UserTarget.get(id: id))
    }
}
