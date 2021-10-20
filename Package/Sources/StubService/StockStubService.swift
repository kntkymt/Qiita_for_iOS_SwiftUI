//
//  StockStubService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import Repository
import Model

public final class StockStubService: StockRepository {

    // MARK: - Initializer

    public init() { }

    // MARK: - Public

    public func getStocks(page: Int, perPage: Int) async throws -> [Item] {
        return await withCheckedContinuation { $0.resume(returning: ItemStubService.items) }
    }

    public func stock(id: Item.ID) async throws -> VoidModel {
        return await withCheckedContinuation { $0.resume(returning: VoidModel()) }
    }

    public func unstock(id: Item.ID) async throws -> VoidModel {
        return await withCheckedContinuation { $0.resume(returning: VoidModel()) }
    }

    public func checkIsStocked(id: Item.ID) async throws -> VoidModel {
        return await withCheckedContinuation { $0.resume(returning: VoidModel()) }
    }
}
