//
//  ItemRepository.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Combine

enum SearchType {
    case word(String)
    case tag(ItemTag)
}

protocol ItemRepository {

    /// 新着記事一覧を取得する
    func getItems(page: Int) -> AnyPublisher<[Item], Error>

    /// 新着記事一覧から検索する
    func getItems(with type: SearchType?, page: Int) -> AnyPublisher<[Item], Error>

    /// 特定のユーザーの記事一覧を取得する
    func getItems(by user: User, page: Int, perPage: Int) -> AnyPublisher<[Item], Error>

    /// 自分の記事一覧を取得する
    func getAuthenticatedUserItems(page: Int, perPage: Int) -> AnyPublisher<[Item], Error>
}
