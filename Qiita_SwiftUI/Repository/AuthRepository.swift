//
//  AuthRepository.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

protocol AuthRepository {

    /// ログイン中かどうか
    var isSignedin: Bool { get }

    /// DeepLinkを処理する
    func handleDeepLink(url: URL)

    /// ログイン中のユーザーを取得する
    func getCurrentUser() async throws -> User

    /// ログインする
    func signin() async throws -> AuthModel

    /// ログアウトする
    func signout() async throws -> Void
}
