//
//  ItemDetailViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/08/28.
//

import Foundation
import SwiftUI
import Combine

final class ItemDetailViewModel: ObservableObject, Identifiable {

    // MARK: - Property

    private let likeRepository: LikeRepository
    private let stockRepository: StockRepository
    private var cancellables = [AnyCancellable]()

    @Published var item: Item
    @Published var isLiked: Bool = false
    @Published var isStocked: Bool = false

    // MARK: - Initializer

    init(item: Item, likeRepository: LikeRepository, stockRepository: StockRepository) {
        self.item = item
        self.likeRepository = likeRepository
        self.stockRepository = stockRepository

        checkIsLiked()
        checkIsStocked()
    }

    // MARK: - Public

    func like() {
        isLiked = true
        likeRepository.like(id: item.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.isLiked = false
                    Logger.error(error)
                }
            }, receiveValue: { _ in
            }).store(in: &cancellables)
    }

    func disLike() {
        isLiked = false
        likeRepository.unlike(id: item.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.isLiked = true
                    Logger.error(error)
                }
            }, receiveValue: { _ in
            }).store(in: &cancellables)
    }

    func stock() {
        isStocked = true
        stockRepository.stock(id: item.id)
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

    private func checkIsLiked() {
        likeRepository.checkIsLiked(id: item.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.isLiked = false
                    Logger.error(error)
                }
            }, receiveValue: { _ in
                self.isLiked = true
            }).store(in: &cancellables)
    }

    private func checkIsStocked() {
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
