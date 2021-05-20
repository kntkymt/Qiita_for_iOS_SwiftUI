//
//  TagStubService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/20.
//

import Foundation
import Combine

final class TagStubService: TagRepository {

    private let tags: [ItemTag] = []

    func getTags(page: Int, perPage: Int, sort: String) -> AnyPublisher<[ItemTag], Error> {
        return Future { $0(.success(self.tags)) }.eraseToAnyPublisher()
    }

    func follow(id: ItemTag.ID) -> AnyPublisher<VoidModel, Error> {
        return Future { $0(.success(VoidModel())) }.eraseToAnyPublisher()
    }

    func unfollow(id: ItemTag.ID) -> AnyPublisher<VoidModel, Error> {
        return Future { $0(.success(VoidModel())) }.eraseToAnyPublisher()
    }

    func checkIsFollowed(id: ItemTag.ID) -> AnyPublisher<VoidModel, Error> {
        return Future { $0(.success(VoidModel())) }.eraseToAnyPublisher()
    }
}
