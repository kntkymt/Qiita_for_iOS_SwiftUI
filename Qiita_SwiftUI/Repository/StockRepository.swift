//
//  StockRepository.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

protocol StockRepository {

    /// ストック記事一覧を取得する
    func getStocks(page: Int, perPage: Int) async throws -> [Item]

    /// 記事をストックする
    func stock(id: Item.ID) async throws -> VoidModel

    /// 記事のストックを解除する
    func unstock(id: Item.ID) async throws -> VoidModel

    /// 記事をストックしているか確認する
    func checkIsStocked(id: Item.ID) async throws -> VoidModel
}
