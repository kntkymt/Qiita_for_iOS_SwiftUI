//
//  LikeService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Combine

final class LikeService: LikeRepository {

    func like(id: Item.ID) -> AnyPublisher<VoidModel, Error> {
        return API.shared.call(ItemTarget.like(id: id))
    }

    func unlike(id: Item.ID) -> AnyPublisher<VoidModel, Error> {
        return API.shared.call(ItemTarget.unlike(id: id))
    }

    func checkIsLiked(id: Item.ID) -> AnyPublisher<VoidModel, Error> {
        return API.shared.call(ItemTarget.checkIsLiked(id: id))
    }
}
