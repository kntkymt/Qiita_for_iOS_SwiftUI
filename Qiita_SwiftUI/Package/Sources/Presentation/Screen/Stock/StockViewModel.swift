//
//  StockViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import Foundation
import Repository
import Model
import Common

@MainActor
public final class StockViewModel: ObservableObject {

    // MARK: - Property

    @Published var items: [Item] = []
    @Published var isLoading: Bool = false

    private(set) var onItemStock: ((_ item: Item, _ status: Bool) -> Void)?

    private var page = 1
    private var isPageLoading = false

    private let stockRepository: StockRepository

    // MARK: - Initializer

    init(stockRepository: StockRepository) {
        self.stockRepository = stockRepository

        self.onItemStock = { [weak self] (item, status) in
            guard let self = self, let targetIndex = self.items.firstIndex(where: { $0.id == item.id }) else { return }
            self.items.remove(at: targetIndex)
        }
    }

    // MARK: - Public

    func fetchItems() async {
        isLoading = true
        do {
            items = try await stockRepository.getStocks(page: 1, perPage: 20)
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
            items += try await stockRepository.getStocks(page: page + 1, perPage: 20)
            page += 1
        } catch {
            Logger.error(error)
        }
        isPageLoading = false
    }
}
