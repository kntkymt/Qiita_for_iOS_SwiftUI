//
//  HomeViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import Foundation
import Model
import Repository
import Common

@MainActor
public final class HomeViewModel: ObservableObject {

    // MARK: - Property

    @Published var items: [Item] = []

    private var page = 1
    private var isPageLoading = false

    private let itemRepository: ItemRepository

    // MARK: - Initializer

    init(itemRepository: ItemRepository) {
        self.itemRepository = itemRepository
    }

    // MARK: - Public

    func fetchItems() async {
        do {
            items = try await itemRepository.getItems(page: 1)
            page = 1
        } catch {
            Logger.error(error)
        }
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
        isPageLoading = false
    }
}
