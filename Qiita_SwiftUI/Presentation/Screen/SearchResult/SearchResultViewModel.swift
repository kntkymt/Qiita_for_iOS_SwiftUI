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

    private var page = 1
    private var isPageLoading = false

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
                self.page = 1
                self.items = items
            }).store(in: &cancellables)
    }

    func fetchMoreItems() {
        if isPageLoading { return }
        isPageLoading = true
        itemRepository.getItems(page: page + 1)
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
