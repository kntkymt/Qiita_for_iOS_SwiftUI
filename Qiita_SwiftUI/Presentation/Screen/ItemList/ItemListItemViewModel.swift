//
//  ItemListViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/09/07.
//

import Foundation
import SwiftUI

@MainActor
final class ItemListItemViewModel: ObservableObject, Identifiable {

    // MARK: - Property

    let item: Item

    @Published var isStocked: Bool = false

    let onItemStockChangedHandler: ((Item, Bool) -> Void)?

    private let stockRepository: StockRepository
    private let likeRepository: LikeRepository

    // MARK: - Initializer

    init(item: Item, onItemStockChangedHandler: ((Item, Bool) -> Void)? = nil, stockRepository: StockRepository, likeRepository: LikeRepository) {
        self.item = item
        self.onItemStockChangedHandler = onItemStockChangedHandler
        self.stockRepository = stockRepository
        self.likeRepository = likeRepository
    }

    // MARK: - Public

    func stock() async {
        isStocked = true
        onItemStockChangedHandler?(item, true)
        do {
            _ = try await stockRepository.stock(id: item.id)
        } catch {
            isStocked = false
            Logger.error(error)
        }
    }

    func unStock() async {
        isStocked = false
        onItemStockChangedHandler?(item, false)
        do {
            _ = try await stockRepository.unstock(id: item.id)
        } catch {
            isStocked = true
            Logger.error(error)
        }
    }

    func checkIsStocked() async {
        do {
            _ = try await stockRepository.checkIsStocked(id: item.id)
            isStocked = true
        } catch {
            isStocked = false
            Logger.error(error)
        }
    }
}

