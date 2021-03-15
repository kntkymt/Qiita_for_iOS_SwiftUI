//
//  AppContainer.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation
import Moya

final class AppContainer {

    // MARK: - Static

    static let shared = AppContainer()

    // MARK: - Property

    let itemRepository: ItemRepository
    let tagRepository: TagRepository
    let stockRepository: StockRepository
    let userRepository: UserRepository
    let likeRepository: LikeRepository
    let authRepository: AuthRepository

    let apiProvider: MoyaProvider<MultiTarget>

    // MARK: - Private

    private init() {
        switch AppEnvironment.shared.buildConfig {
        case .debug, .release:
            itemRepository = ItemService()
            tagRepository = TagService()
            stockRepository = StockService()
            userRepository = UserService()
            likeRepository = LikeService()
            authRepository = AuthService()
            
            apiProvider = APIProviderFactory.createDefault()
        }
    }
}
