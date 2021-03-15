//
//  StockRepository.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Combine

protocol StockRepository {

    /// ストック記事一覧を取得する
    func getStocks(page: Int, perPage: Int) -> AnyPublisher<[Item], Error>

    /// 記事をストックする
    func stock(id: Item.ID) -> AnyPublisher<VoidModel, Error>

    /// 記事のストックを解除する
    func unstock(id: Item.ID) -> AnyPublisher<VoidModel, Error>

    /// 記事をストックしているか確認する
    func checkIsStocked(id: Item.ID) -> AnyPublisher<VoidModel, Error>
}
