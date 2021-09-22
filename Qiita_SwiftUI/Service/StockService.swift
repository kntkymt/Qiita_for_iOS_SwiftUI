//
//  StockService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

final class StockService: StockRepository {

    func getStocks(page: Int, perPage: Int) async throws -> [Item] {
        let user = try await Auth.shared.getCurrentUser()
        return try await API.shared.call(UserTarget.getStocks(page: page, perPage: perPage, id: user.id))
    }

    func stock(id: Item.ID) async throws -> VoidModel {
        return try await API.shared.call(ItemTarget.stock(id: id))
    }

    func unstock(id: Item.ID) async throws -> VoidModel {
        return try await API.shared.call(ItemTarget.unstock(id: id))
    }

    func checkIsStocked(id: Item.ID) async throws -> VoidModel {
        return try await API.shared.call(ItemTarget.checkIsStocked(id: id))
    }
}
