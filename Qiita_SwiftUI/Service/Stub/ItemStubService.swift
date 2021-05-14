//
//  ItemStubService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import Foundation
import Combine

final class ItemStubService: ItemRepository {

    // MARK: - Property

    static let items: [Item] = (0..<10).map { Item(title: "Hello Word!", id: $0.description, url: URL(string: "https://qiita.com")!, likesCount: $0.isMultiple(of: 2) ? 3 * $0 : $0, createdAt: Date(), user: User(id: "kntkymt", name: "kntkymt", description: "iOSエンジニアです", profileImageUrl: URL(string: "https://avatars2.githubusercontent.com/u/44288050?v=4")!, itemsCount: 4, followeesCount: 3, followersCount: 3)) }

    // MARK: - Public

    func getItems(page: Int) -> AnyPublisher<[Item], Error> {
        return Future { $0(.success(Self.items)) }.eraseToAnyPublisher()
    }

    // FIXME: Optionalやめたい
    func getItems(with type: SearchType?, page: Int) -> AnyPublisher<[Item], Error> {
        switch type {
        case .word:
            return Future { $0(.success(Self.items)) }.eraseToAnyPublisher()

        case .tag:
            return Future { $0(.success(Self.items)) }.eraseToAnyPublisher()

        case .none:
            return getItems(page: page)
        }
    }

    // TODO: UserServiceに置く？
    func getItems(by user: User, page: Int, perPage: Int) -> AnyPublisher<[Item], Error> {
        return Future { $0(.success(Self.items)) }.eraseToAnyPublisher()
    }

    func getAuthenticatedUserItems(page: Int, perPage: Int) -> AnyPublisher<[Item], Error> {
        return Future { $0(.success(Self.items)) }.eraseToAnyPublisher()
    }
}
