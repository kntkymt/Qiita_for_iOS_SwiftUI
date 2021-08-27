//
//  HomeViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {

    // MARK: - Property

    @Published var items: [Item] = []
    @Published var isRefreshing = false

    private let itemRepository: ItemRepository
    private var cancellables = [AnyCancellable]()

    // MARK: - Initializer

    init(itemRepository: ItemRepository) {
        self.itemRepository = itemRepository

        fetchItems()
    }

    // MARK: - Public

    func fetchItems() {
        itemRepository.getItems(page: 1)
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
                self.items = items
            }).store(in: &cancellables)
    }
}
