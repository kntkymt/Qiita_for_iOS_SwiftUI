//
//  StockStubService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//


final class StockStubService: StockRepository {

    func getStocks(page: Int, perPage: Int) async throws -> [Item] {
        return await withCheckedContinuation { $0.resume(returning: ItemStubService.items) }
    }

    func stock(id: Item.ID) async throws -> VoidModel {
        return await withCheckedContinuation { $0.resume(returning: VoidModel()) }
    }

    func unstock(id: Item.ID) async throws -> VoidModel {
        return await withCheckedContinuation { $0.resume(returning: VoidModel()) }
    }

    func checkIsStocked(id: Item.ID) async throws -> VoidModel {
        return await withCheckedContinuation { $0.resume(returning: VoidModel()) }
    }
}
