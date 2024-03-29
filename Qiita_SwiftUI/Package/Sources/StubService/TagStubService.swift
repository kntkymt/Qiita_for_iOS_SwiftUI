//
//  TagStubService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/20.
//

import Foundation
import Repository
import Model

public final class TagStubService: TagRepository {

    // MARK: - Property

    private let tags: [ItemTag] = [
        ItemTag(iconUrl: URL(string: "https://avatars2.githubusercontent.com/u/44288050?v=4")!, followersCount: 10, id: "python", itemsCount: 10),
        ItemTag(iconUrl: URL(string: "https://avatars2.githubusercontent.com/u/44288050?v=4")!, followersCount: 10, id: "iOS", itemsCount: 10),
        ItemTag(iconUrl: URL(string: "https://avatars2.githubusercontent.com/u/44288050?v=4")!, followersCount: 10, id: "Swift", itemsCount: 10),
        ItemTag(iconUrl: URL(string: "https://avatars2.githubusercontent.com/u/44288050?v=4")!, followersCount: 10, id: "Android", itemsCount: 10),
        ItemTag(iconUrl: URL(string: "https://avatars2.githubusercontent.com/u/44288050?v=4")!, followersCount: 10, id: "Kotlin", itemsCount: 10),
        ItemTag(iconUrl: URL(string: "https://avatars2.githubusercontent.com/u/44288050?v=4")!, followersCount: 10, id: "Java", itemsCount: 10),
        ItemTag(iconUrl: URL(string: "https://avatars2.githubusercontent.com/u/44288050?v=4")!, followersCount: 10, id: "Ruby", itemsCount: 10)
    ]

    // MARK: - Initializer

    public init() { }

    // MARK: - Public

    public func getTags(page: Int, perPage: Int, sort: String) async throws -> [ItemTag] {
        return await withCheckedContinuation { $0.resume(returning: self.tags) }
    }

    public func follow(id: ItemTag.ID) async throws -> VoidModel {
        return await withCheckedContinuation { $0.resume(returning: VoidModel()) }
    }

    public func unfollow(id: ItemTag.ID) async throws -> VoidModel {
        return await withCheckedContinuation { $0.resume(returning: VoidModel()) }
    }

    public func checkIsFollowed(id: ItemTag.ID) async throws -> VoidModel {
        return await withCheckedContinuation { $0.resume(returning: VoidModel()) }
    }
}
