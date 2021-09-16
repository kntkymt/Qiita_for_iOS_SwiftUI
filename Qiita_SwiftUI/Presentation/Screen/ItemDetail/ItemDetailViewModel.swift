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

    @Published var item: Item
    @Published var isLiked: Bool = false
    @Published var isStocked: Bool = false

    private let likeRepository: LikeRepository
    private let stockRepository: StockRepository
    private var cancellables = [AnyCancellable]()

    // MARK: - Initializer

    init(item: Item, likeRepository: LikeRepository, stockRepository: StockRepository) {
        self.item = item
        self.likeRepository = likeRepository
        self.stockRepository = stockRepository
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

    func checkIsLiked() {
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
