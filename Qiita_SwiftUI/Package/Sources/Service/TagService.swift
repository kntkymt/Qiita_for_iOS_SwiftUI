//
//  TagService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Repository
import Model
import Network

public final class TagService: TagRepository {

    public init() { }

    public func getTags(page: Int, perPage: Int, sort: String) async throws -> [ItemTag] {
        return try await API.shared.call(TagTarget.getTags(page: page, perPage: perPage, sort: sort))
    }

    public func follow(id: ItemTag.ID) async throws -> VoidModel {
        return try await API.shared.call(TagTarget.follow(id: id))
    }

    public func unfollow(id: ItemTag.ID) async throws -> VoidModel {
        return try await API.shared.call(TagTarget.unfollow(id: id))
    }

    public func checkIsFollowed(id: ItemTag.ID) async throws -> VoidModel {
        return try await API.shared.call(TagTarget.checkIsFollowed(id: id))
    }
}
