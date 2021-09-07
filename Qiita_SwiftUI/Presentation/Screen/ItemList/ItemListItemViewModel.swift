//
//  ItemListViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/09/07.
//

import Foundation
import SwiftUI
import Combine

final class ItemListItemViewModel: ObservableObject, Identifiable {

    // MARK: - Property

    let item: Item

    @Published var isStocked: Bool = false

    let onItemStockChangedHandler: ((Item, Bool) -> Void)?

    let stockRepository: StockRepository
    let likeRepository: LikeRepository
    private var cancellables = [AnyCancellable]()

    // MARK: - Initializer

    init(item: Item, onItemStockChangedHandler: ((Item, Bool) -> Void)? = nil, stockRepository: StockRepository, likeRepository: LikeRepository) {
        self.item = item
        self.onItemStockChangedHandler = onItemStockChangedHandler
        self.stockRepository = stockRepository
        self.likeRepository = likeRepository
    }

    // MARK: - Public

    func stock() {
        isStocked = true
        onItemStockChangedHandler?(item, true)
        stockRepository.stock(id: item.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.isStocked = false
                    Logger.error(error)
                }
            }, receiveValue: { _ in
            }).store(in: &cancellables)
    }

    func unStock() {
        isStocked = false
        onItemStockChangedHandler?(item, false)
        stockRepository.unstock(id: item.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.isStocked = true
                    Logger.error(error)
                }
            }, receiveValue: { _ in
            }).store(in: &cancellables)
    }

    func checkIsStocked() {
        stockRepository.checkIsStocked(id: item.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.isStocked = false
                    Logger.error(error)
                }
            }, receiveValue: { _ in
                self.isStocked = true
            }).store(in: &cancellables)
    }
}

