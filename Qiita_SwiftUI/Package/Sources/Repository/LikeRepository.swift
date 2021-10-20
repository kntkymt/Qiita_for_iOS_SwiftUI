//
//  LikeRepository.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Model

public protocol LikeRepository {

    /// 記事をいいねする
    func like(id: Item.ID) async throws -> VoidModel

    /// 記事のいいねを解除する
    func unlike(id: Item.ID) async throws -> VoidModel

    /// 記事をいいねしているかどうか確認する
    func checkIsLiked(id: Item.ID) async throws -> VoidModel
}
