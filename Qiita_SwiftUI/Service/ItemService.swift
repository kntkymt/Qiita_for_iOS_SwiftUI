//
//  ItemService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Combine

final class ItemService: ItemRepository {

    func getItems(page: Int) async throws -> [Item] {
        return try await API.shared.call(ItemTarget.getItems(page: page))
    }

    func getItems(with type: SearchType?, page: Int) async throws -> [Item] {
        switch type {
        case .word(let word):
            return try await API.shared.call(ItemTarget.getItemsByQuery(page: page, query: word))

        case .tag(let tag):
            return try await API.shared.call(TagTarget.getItems(page: page, id: tag.id))

        case .none:
            return try await getItems(page: page)
        }
    }

    func getItems(by user: User, page: Int, perPage: Int) async throws -> [Item] {
        return try await API.shared.call(UserTarget.getItems(page: page, perPage: perPage, id: user.id))
    }

    func getAuthenticatedUserItems(page: Int, perPage: Int) async throws -> [Item] {
        return try await API.shared.call(UserTarget.getAuthenticatedUserItems(page: page, perPage: perPage))
    }
}
