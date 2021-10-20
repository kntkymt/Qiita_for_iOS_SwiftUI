//
//  LikeService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Repository
import Model
import Network

public final class LikeService: LikeRepository {

    public init() { }

    public func like(id: Item.ID) async throws -> VoidModel {
        return try await API.shared.call(ItemTarget.like(id: id))
    }

    public func unlike(id: Item.ID) async throws -> VoidModel {
        return try await API.shared.call(ItemTarget.unlike(id: id))
    }

    public func checkIsLiked(id: Item.ID) async throws -> VoidModel {
        return try await API.shared.call(ItemTarget.checkIsLiked(id: id))
    }
}
