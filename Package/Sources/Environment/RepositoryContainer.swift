//
//  RepositoryContainer.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/09/13.
//

import Foundation
import Repository
import Service

public final class RepositoryContainer: ObservableObject {

    // MARK: - Property

    public let itemRepository: ItemRepository
    public let tagRepository: TagRepository
    public let stockRepository: StockRepository
    public let userRepository: UserRepository
    public let likeRepository: LikeRepository
    public let authRepository: AuthRepository

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

public final class RepositoryContainerFactory {

    static func createServices() -> RepositoryContainer {
        return RepositoryContainer(itemRepository: ItemService(), tagRepository: TagService(), stockRepository: StockService(), userRepository: UserService(), likeRepository: LikeService(), authRepository: AuthService())
    }

    static func createStubs() -> RepositoryContainer {
        return RepositoryContainer(itemRepository: ItemStubService(), tagRepository: TagStubService(), stockRepository: StockStubService(), userRepository: UserStubService(), likeRepository: LikeStubService(), authRepository: AuthStubService())
    }
}

