//
//  TagService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Combine

final class TagService: TagRepository {

    func getTags(page: Int, perPage: Int, sort: String) -> AnyPublisher<[ItemTag], Error> {
        return API.shared.call(TagTarget.getTags(page: page, perPage: perPage, sort: sort)).eraseToAnyPublisher()
    }

    func follow(id: ItemTag.ID) -> AnyPublisher<VoidModel, Error> {
        return API.shared.call(TagTarget.follow(id: id)).eraseToAnyPublisher()
    }

    func unfollow(id: ItemTag.ID) -> AnyPublisher<VoidModel, Error> {
        return API.shared.call(TagTarget.unfollow(id: id)).eraseToAnyPublisher()
    }

    func checkIsFollowed(id: ItemTag.ID) -> AnyPublisher<VoidModel, Error> {
        return API.shared.call(TagTarget.checkIsFollowed(id: id)).eraseToAnyPublisher()
    }
}