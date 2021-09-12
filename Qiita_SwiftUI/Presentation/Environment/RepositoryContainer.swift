//
//  RepositoryContainer.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/09/13.
//

import Foundation

final class RepositoryContainer: ObservableObject {

    // MARK: - Property

    let itemRepository: ItemRepository
    let tagRepository: TagRepository
    let stockRepository: StockRepository
    let userRepository: UserRepository
    let likeRepository: LikeRepository
    let authRepository: AuthRepository

    // MARK: - Initializer
    init(itemRepository: ItemRepository, tagRepository: TagRepository, stockRepository: StockRepository, userRepository: UserRepository, likeRepository: LikeRepository, authRepository: AuthRepository) {
        self.itemRepository = itemRepository
        self.tagRepository = tagRepository
        self.stockRepository = stockRepository
        self.userRepository = userRepository
        self.likeRepository = likeRepository
        self.authRepository = authRepository
    }
}

final class RepositoryContainerFactory {

    static func createServices() -> RepositoryContainer {
        return RepositoryContainer(itemRepository: ItemService(), tagRepository: TagService(), stockRepository: StockService(), userRepository: UserService(), likeRepository: LikeService(), authRepository: AuthService())
    }

    static func createStubs() -> RepositoryContainer {
        return RepositoryContainer(itemRepository: ItemStubService(), tagRepository: TagStubService(), stockRepository: StockStubService(), userRepository: UserStubService(), likeRepository: LikeStubService(), authRepository: AuthStubService())
    }
}

