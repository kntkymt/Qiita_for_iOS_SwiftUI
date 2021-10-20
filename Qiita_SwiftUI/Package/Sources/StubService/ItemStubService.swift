//
//  ItemStubService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import Foundation
import Repository
import Model

public final class ItemStubService: ItemRepository {

    // MARK: - Property

    static let items: [Item] = (0..<10).map { Item(title: "Hello Word!", id: $0.description, url: URL(string: "https://qiita.com")!, likesCount: $0.isMultiple(of: 2) ? 3 * $0 : $0, createdAt: Date(), user: User(id: "kntkymt", name: "kntkymt", description: "iOSエンジニアです", profileImageUrl: URL(string: "https://avatars2.githubusercontent.com/u/44288050?v=4")!, itemsCount: 4, followeesCount: 3, followersCount: 3)) }

    // MARK: - Initializer

    public init() { }

    // MARK: - Public

    public func getItems(page: Int) async throws -> [Item] {
        return await withCheckedContinuation { $0.resume(returning: Self.items) }
    }

    public func getItems(with type: SearchType?, page: Int) async throws -> [Item] {
        return await withCheckedContinuation { $0.resume(returning: Self.items) }
    }

    // TODO: UserServiceに置く？
    public func getItems(by user: User, page: Int, perPage: Int) async throws -> [Item] {
        return await withCheckedContinuation { $0.resume(returning: Self.items) }
    }

    public func getAuthenticatedUserItems(page: Int, perPage: Int) async throws -> [Item] {
        return await withCheckedContinuation { $0.resume(returning: Self.items) }
    }
}
