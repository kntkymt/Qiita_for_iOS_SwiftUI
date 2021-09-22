//
//  ItemDetailViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/08/28.
//

import Foundation
import SwiftUI

@MainActor
final class ItemDetailViewModel: ObservableObject, Identifiable {

    // MARK: - Property

    @Published var item: Item
    @Published var isLiked: Bool = false
    @Published var isStocked: Bool = false

    private let likeRepository: LikeRepository
    private let stockRepository: StockRepository

    // MARK: - Initializer

    init(item: Item, likeRepository: LikeRepository, stockRepository: StockRepository) {
        self.item = item
        self.likeRepository = likeRepository
        self.stockRepository = stockRepository
    }

    // MARK: - Public

    func like() async {
        isLiked = true
        do {
            _ = try await likeRepository.like(id: item.id)
        } catch {
            isLiked = false
            Logger.error(error)
        }
    }

    func disLike() async {
        isLiked = false
        do {
            _ = try await likeRepository.unlike(id: item.id)
        } catch {
            isLiked = true
            Logger.error(error)
        }
    }

    func stock() async {
        isStocked = true
        do {
            _ = try await stockRepository.stock(id: item.id)
        } catch {
            isStocked = false
            Logger.error(error)
        }
    }

    func unStock() async {
        isStocked = false
        do {
            _ = try await stockRepository.unstock(id: item.id)
        } catch {
            isStocked = true
            Logger.error(error)
        }
    }

    func checkIsLiked() async {
        do {
            _ = try await likeRepository.checkIsLiked(id: item.id)
            isLiked = true
        } catch {
            isLiked = false
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
