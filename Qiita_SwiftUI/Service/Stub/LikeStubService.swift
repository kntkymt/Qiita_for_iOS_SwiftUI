//
//  LikeStubService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/08/28.
//

import Foundation

final class LikeStubService: LikeRepository {

    func like(id: Item.ID) async throws -> VoidModel {
        return await withCheckedContinuation { $0.resume(returning: VoidModel()) }
    }

    func unlike(id: Item.ID) async throws -> VoidModel {
        return await withCheckedContinuation { $0.resume(returning: VoidModel()) }
    }

    func checkIsLiked(id: Item.ID) async throws -> VoidModel {
        return await withCheckedContinuation { $0.resume(returning: VoidModel()) }
    }
}
