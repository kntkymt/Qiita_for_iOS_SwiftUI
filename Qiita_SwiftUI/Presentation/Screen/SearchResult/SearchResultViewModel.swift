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
    let searchWord: String

    private let itemRepository: ItemRepository
    private var cancellables = [AnyCancellable]()

    // MARK: - Initializer

    init(searchWord: String, itemRepository: ItemRepository) {
        self.searchWord = searchWord
        self.itemRepository = itemRepository

        fetchItems()
    }

    // MARK: - Public

    func fetchItems() {
        itemRepository.getItems(with: .word(searchWord), page: 1)
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

