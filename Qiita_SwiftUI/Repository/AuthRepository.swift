//
//  AuthRepository.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Combine
import Foundation

protocol AuthRepository {

    /// ログイン中かどうか
    var isSignedin: Bool { get }

    /// DeepLinkを処理する
    func handleDeepLink(url: URL)

    /// ログイン中のユーザーを取得する
    func getCurrentUser() -> AnyPublisher<User, Error>

    /// ログインする
    func signin() -> AnyPublisher<AuthModel, Error>

    /// ログアウトする
    func signout() -> AnyPublisher<Void, Error>
}
