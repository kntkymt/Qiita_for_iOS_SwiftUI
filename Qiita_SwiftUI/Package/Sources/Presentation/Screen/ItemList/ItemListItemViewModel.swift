//
//  ItemListViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/09/07.
//

import Foundation
import SwiftUI
import Model
import Repository
import Common

@MainActor
public final class ItemListItemViewModel: ObservableObject, Identifiable {

    // MARK: - Property

    let item: Item

    @Published var isStocked: Bool = false

    let onItemStock: ((_ item: Item, _ status: Bool) -> Void)?

    private let stockRepository: StockRepository
    private let likeRepository: LikeRepository

    // MARK: - Initializer

    init(item: Item, onItemStock: ((_ item: Item, _ status: Bool) -> Void)? = nil, stockRepository: StockRepository, likeRepository: LikeRepository) {
        self.item = item
        self.onItemStock = onItemStock
        self.stockRepository = stockRepository
        self.likeRepository = likeRepository
    }

    // MARK: - Public

    func stock() async {
        isStocked = true
        onItemStock?(item, true)
        do {
            _ = try await stockRepository.stock(id: item.id)
        } catch {
            isStocked = false
            Logger.error(error)
        }
    }

    func unStock() async {
        isStocked = false
        onItemStock?(item, false)
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

