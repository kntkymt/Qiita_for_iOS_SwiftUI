//
//  LikeStubService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/08/28.
//

import Foundation
import Combine

final class LikeStubService: LikeRepository {

    func like(id: Item.ID) -> AnyPublisher<VoidModel, Error> {
        return Future { $0(.success(VoidModel())) }.eraseToAnyPublisher()
    }

    func unlike(id: Item.ID) -> AnyPublisher<VoidModel, Error> {
        return Future { $0(.success(VoidModel())) }.eraseToAnyPublisher()
    }

    func checkIsLiked(id: Item.ID) -> AnyPublisher<VoidModel, Error> {
        return Future { $0(.success(VoidModel())) }.eraseToAnyPublisher()
    }
}
