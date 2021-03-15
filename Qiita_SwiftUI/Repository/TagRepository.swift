//
//  TagRepository.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Combine

protocol TagRepository {

    /// タグ一覧を取得する
    func getTags(page: Int, perPage: Int, sort: String) -> AnyPublisher<[ItemTag], Error>

    /// タグをフォローする
    func follow(id: ItemTag.ID) -> AnyPublisher<VoidModel, Error>

    /// タグのフォローを外す
    func unfollow(id: ItemTag.ID) -> AnyPublisher<VoidModel, Error>

    /// タグをフォローしているか確かめる
    func checkIsFollowed(id: ItemTag.ID) -> AnyPublisher<VoidModel, Error>
}
