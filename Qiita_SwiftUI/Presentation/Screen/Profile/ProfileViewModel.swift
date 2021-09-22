//
//  ProfileViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/20.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {

    // MARK: - Property

    @Published var user: User?
    @Published var items: [Item] = []
    @Published var isRefreshing = false

    private var page = 1
    private var isPageLoading = false

    private let authRepository: AuthRepository
    private let itemRepository: ItemRepository

    // MARK: - Initializer

    init(authRepository: AuthRepository, itemRepository: ItemRepository) {
        self.authRepository = authRepository
        self.itemRepository = itemRepository
    }

    // MARK: - Public

    func fetchUser() async {
        do {
            user = try await authRepository.getCurrentUser()
        } catch {
            Logger.error(error)
        }
    }

    func fetchItems() async {
        do {
            items = try await itemRepository.getAuthenticatedUserItems(page: 1, perPage: 20)
            page = 1
        } catch {
            Logger.error(error)
        }
        isRefreshing = false
    }

    func fetchMoreItems() async {
        if isPageLoading { return }
        isPageLoading = true
        do {
            items += try await itemRepository.getAuthenticatedUserItems(page: page + 1, perPage: 20)
            page += 1
        } catch {
            Logger.error(error)
        }
        isRefreshing = false
        isPageLoading = false
    }
}

