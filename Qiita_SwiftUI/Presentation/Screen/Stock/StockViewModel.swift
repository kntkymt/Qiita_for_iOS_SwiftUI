//
//  StockViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import Foundation
import Combine

final class StockViewModel: ObservableObject {

    // MARK: - Property

    @Published var items: [Item] = []
    @Published var isRefreshing = false

    private(set) var onItemStockChangedHandler: ((Item, Bool) -> Void)?

    private var page = 1
    private var isPageLoading = false

    private let stockRepository: StockRepository
    private var cancellables = [AnyCancellable]()

    // MARK: - Initializer

    init(stockRepository: StockRepository) {
        self.stockRepository = stockRepository

        self.onItemStockChangedHandler = { [weak self] (item, status) in
            guard let self = self, let targetIndex = self.items.firstIndex(where: { $0.id == item.id }) else { return }
            self.items.remove(at: targetIndex)
        }
    }

    // MARK: - Public

    func fetchItems() {
        stockRepository.getStocks(page: 1, perPage: 20)
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
        stockRepository.getStocks(page: page + 1, perPage: 20)
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
