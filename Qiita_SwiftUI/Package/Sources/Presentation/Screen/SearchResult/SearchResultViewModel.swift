//
//  SearchResultViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/21.
//

import Foundation
import Model
import Repository
import Common

@MainActor
public final class SearchResultViewModel: ObservableObject {

    // MARK: - Property

    @Published var items: [Item] = []
    @Published var isLoading: Bool = false

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
        isLoading = true
        do {
            items = try await itemRepository.getItems(with: searchType, page: 1)
            page = 1
        } catch {
            Logger.error(error)
        }
        isLoading = false
    }

    func fetchMoreItems() async {
        if isPageLoading { return }
        isPageLoading = true
        do {
            items += try await itemRepository.getItems(with: searchType, page: page + 1)
            page += 1
        } catch {
            Logger.error(error)
        }
        isPageLoading = false
    }
}
