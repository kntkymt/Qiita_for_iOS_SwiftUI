//
//  LikeStubService.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/08/28.
//

import Foundation
import Repository
import Model

public final class LikeStubService: LikeRepository {

    // MARK: - Initializer

    public init() { }

    // MARK: - Public

    public func like(id: Item.ID) async throws -> VoidModel {
        return await withCheckedContinuation { $0.resume(returning: VoidModel()) }
    }

    public func unlike(id: Item.ID) async throws -> VoidModel {
        return await withCheckedContinuation { $0.resume(returning: VoidModel()) }
    }

    public func checkIsLiked(id: Item.ID) async throws -> VoidModel {
        return await withCheckedContinuation { $0.resume(returning: VoidModel()) }
    }
}
