//
//  TagRepository.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Model

public protocol TagRepository {

    /// タグ一覧を取得する
    func getTags(page: Int, perPage: Int, sort: String) async throws -> [ItemTag]

    /// タグをフォローする
    func follow(id: ItemTag.ID) async throws -> VoidModel

    /// タグのフォローを外す
    func unfollow(id: ItemTag.ID) async throws -> VoidModel

    /// タグをフォローしているか確かめる
    func checkIsFollowed(id: ItemTag.ID) async throws -> VoidModel
}
