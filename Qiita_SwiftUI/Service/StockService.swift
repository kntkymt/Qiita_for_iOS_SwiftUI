//
//  StockService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Combine

final class StockService: StockRepository {

    func getStocks(page: Int, perPage: Int) -> AnyPublisher<[Item], Error> {
        return Auth.shared.currentUser
            .then { user in
                API.shared.call(UserTarget.getStocks(page: page, perPage: perPage, id: user.id))
            }
    }

    func stock(id: Item.ID) -> AnyPublisher<VoidModel, Error> {
        return API.shared.call(ItemTarget.stock(id: id))
    }

    func unstock(id: Item.ID) -> AnyPublisher<VoidModel, Error> {
        return API.shared.call(ItemTarget.unstock(id: id))
    }

    func checkIsStocked(id: Item.ID) -> AnyPublisher<VoidModel, Error> {
        return API.shared.call(ItemTarget.checkIsStocked(id: id))
    }
}
