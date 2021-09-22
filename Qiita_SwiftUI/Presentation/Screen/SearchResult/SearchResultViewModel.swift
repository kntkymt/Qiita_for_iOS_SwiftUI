//
//  SearchResultViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/21.
//

import Foundation

@MainActor
final class SearchResultViewModel: ObservableObject {

    // MARK: - Property

    @Published var items: [Item] = []
    @Published var isRefreshing = false
    let searchType: SearchType

    private var page = 1
    private var isPageLoading = false

    private let itemRepository: ItemRepository

    // MARK: - Initializer

    init(searchType: SearchType, itemRepository: ItemRepository) {
        self.searchType = searchType
        self.itemRepository = itemRepository
    }

    // MARK: - Public

    func fetchItems() async {
        do {
            items = try await itemRepository.getItems(with: searchType, page: 1)
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
            items += try await itemRepository.getItems(page: page + 1)
            page += 1
        } catch {
            Logger.error(error)
        }
        isRefreshing = false
        isPageLoading = false
    }
}
