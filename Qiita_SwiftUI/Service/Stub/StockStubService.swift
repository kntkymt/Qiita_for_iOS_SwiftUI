//
//  StockStubService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import Combine

final class StockStubService: StockRepository {

    func getStocks(page: Int, perPage: Int) -> AnyPublisher<[Item], Error> {
        return Future { $0(.success(ItemStubService.items)) }.eraseToAnyPublisher()
    }

    func stock(id: Item.ID) -> AnyPublisher<VoidModel, Error> {
        return Future { $0(.success(VoidModel())) }.eraseToAnyPublisher()
    }

    func unstock(id: Item.ID) -> AnyPublisher<VoidModel, Error> {
        return Future { $0(.success(VoidModel())) }.eraseToAnyPublisher()
    }

    func checkIsStocked(id: Item.ID) -> AnyPublisher<VoidModel, Error> {
        return Future { $0(.success(VoidModel())) }.eraseToAnyPublisher()
    }
}
