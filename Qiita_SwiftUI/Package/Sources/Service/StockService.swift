//
//  StockService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Repository
import Model
import Network

public final class StockService: StockRepository {

    public init() { }

    public func getStocks(page: Int, perPage: Int) async throws -> [Item] {
        let user = try await Auth.shared.getCurrentUser()
        return try await API.shared.call(UserTarget.getStocks(page: page, perPage: perPage, id: user.id))
    }

    public func stock(id: Item.ID) async throws -> VoidModel {
        return try await API.shared.call(ItemTarget.stock(id: id))
    }

    public func unstock(id: Item.ID) async throws -> VoidModel {
        return try await API.shared.call(ItemTarget.unstock(id: id))
    }

    public func checkIsStocked(id: Item.ID) async throws -> VoidModel {
        return try await API.shared.call(ItemTarget.checkIsStocked(id: id))
    }
}
