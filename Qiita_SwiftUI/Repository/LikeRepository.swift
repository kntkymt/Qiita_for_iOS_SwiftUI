//
//  LikeRepository.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Combine

protocol LikeRepository {

    /// 記事をいいねする
    func like(id: Item.ID) -> AnyPublisher<VoidModel, Error>

    /// 記事のいいねを解除する
    func unlike(id: Item.ID) -> AnyPublisher<VoidModel, Error>

    /// 記事をいいねしているかどうか確認する
    func checkIsLiked(id: Item.ID) -> AnyPublisher<VoidModel, Error>
}
