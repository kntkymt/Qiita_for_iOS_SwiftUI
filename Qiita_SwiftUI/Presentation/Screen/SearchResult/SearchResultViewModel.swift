//
//  SearchResultViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/21.
//

import Foundation
import Combine

final class SearchResultViewModel: ObservableObject {

    // MARK: - Property

    @Published var items: [Item] = []
    @Published var isRefreshing = false
    let searchType: SearchType

    private let itemRepository: ItemRepository
    private var cancellables = [AnyCancellable]()

    // MARK: - Initializer

    init(searchType: SearchType, itemRepository: ItemRepository) {
        self.searchType = searchType
        self.itemRepository = itemRepository

        fetchItems()
    }

    // MARK: - Public

    func fetchItems() {
        itemRepository.getItems(with: searchType, page: 1)
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

