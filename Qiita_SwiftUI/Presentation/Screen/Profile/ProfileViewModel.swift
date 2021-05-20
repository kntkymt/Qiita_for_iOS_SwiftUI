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

    private let authRepository: AuthRepository
    private let itemRepository: ItemRepository
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
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    Logger.error(error)
                }
            }, receiveValue: { items in
                self.items = items
            }).store(in: &cancellables)
    }
}

