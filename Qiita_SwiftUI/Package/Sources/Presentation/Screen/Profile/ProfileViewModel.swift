//
//  ProfileViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/20.
//

import Foundation
import Model
import Common
import Repository

@MainActor
public final class ProfileViewModel: ObservableObject {

    // MARK: - Property

    @Published var user: User?
    @Published var items: [Item] = []
    @Published var isItemLoading: Bool = false

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
        isItemLoading = true
        do {
            items = try await itemRepository.getAuthenticatedUserItems(page: 1, perPage: 20)
            page = 1
        } catch {
            Logger.error(error)
        }
        isItemLoading = false
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
        isPageLoading = false
    }
}

