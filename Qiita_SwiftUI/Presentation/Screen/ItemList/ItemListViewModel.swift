//
//  ItemListViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/09/07.
//

import Foundation
import SwiftUI
import Combine

final class ItemListViewModel: ObservableObject, Identifiable {

    // MARK: - Property

    let item: Item

    @Published var isStocked: Bool = false

    let stockRepository: StockRepository
    let likeRepository: LikeRepository
    private var cancellables = [AnyCancellable]()

    // MARK: - Initializer

    init(item: Item, stockRepository: StockRepository, likeRepository: LikeRepository) {
        self.item = item
        self.stockRepository = stockRepository
        self.likeRepository = likeRepository

        checkIsStocked()
    }

    // MARK: - Public

    func stock() {
        isStocked = true
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

    // MARK: - Private

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

