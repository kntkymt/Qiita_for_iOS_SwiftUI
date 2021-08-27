//
//  ProfileViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/20.
//

import Foundation
import Combine

final class ProfileViewModel: ObservableObject {

    // MARK: - Property

    @Published var user: User?
    @Published var items: [Item] = []
    @Published var isRefreshing = false

    private var page = 1
    private var isPageLoading = false

    let authRepository: AuthRepository
    let itemRepository: ItemRepository
    private var cancellables = [AnyCancellable]()

    // MARK: - Initializer

    init(authRepository: AuthRepository, itemRepository: ItemRepository) {
        self.authRepository = authRepository
        self.itemRepository = itemRepository

        fetchUser()
        fetchItems()
    }

    // MARK: - Public

    func fetchUser() {
        authRepository.getCurrentUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    Logger.error(error)
                }
            }, receiveValue: { user in
                self.user = user
            }).store(in: &cancellables)
    }

    func fetchItems() {
        itemRepository.getAuthenticatedUserItems(page: 1, perPage: 20)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isRefreshing = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    Logger.error(error)
                }
            }, receiveValue: { items in
                self.page = 1
                self.items = items
            }).store(in: &cancellables)
    }

    func fetchMoreItems() {
            if isPageLoading { return }
            isPageLoading = true
            itemRepository.getAuthenticatedUserItems(page: page + 1, perPage: 20)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    self.isRefreshing = false
                    self.isPageLoading = false
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        Logger.error(error)
                    }
                }, receiveValue: { items in
                    self.page += 1
                    self.items += items
                }).store(in: &cancellables)
        }
}

