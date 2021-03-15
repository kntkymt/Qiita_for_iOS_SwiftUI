//
//  ItemService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Combine

final class ItemService: ItemRepository {

    func getItems(page: Int) -> AnyPublisher<[Item], Error> {
        return API.shared.call(ItemTarget.getItems(page: page))
    }

    // FIXME: Optionalやめたい
    func getItems(with type: SearchType?, page: Int) -> AnyPublisher<[Item], Error> {
        switch type {
        case .word(let word):
            return API.shared.call(ItemTarget.getItemsByQuery(page: page, query: word))
            
        case .tag(let tag):
            return API.shared.call(TagTarget.getItems(page: page, id: tag.id))

        case .none:
            return getItems(page: page)
        }
    }

    // TODO: UserServiceに置く？
    func getItems(by user: User, page: Int, perPage: Int) -> AnyPublisher<[Item], Error> {
        return API.shared.call(UserTarget.getItems(page: page, perPage: perPage, id: user.id))
    }

    func getAuthenticatedUserItems(page: Int, perPage: Int) -> AnyPublisher<[Item], Error> {
        return API.shared.call(UserTarget.getAuthenticatedUserItems(page: page, perPage: perPage))
    }
}
