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

    private let stockRepository: StockRepository
    private var cancellables = [AnyCancellable]()

    // MARK: - Initializer

    init(stockRepository: StockRepository) {
        self.stockRepository = stockRepository

        fetchItems()
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
                self.items = items
            }).store(in: &cancellables)
    }
}
