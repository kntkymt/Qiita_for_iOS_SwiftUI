//
//  UserService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Combine

protocol UserRepository {

    /// 特定のユーザーを取得する
    func getUser(id: User.ID) -> AnyPublisher<User, Error>
}
