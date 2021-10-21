//
//  TagInformationViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/09/13.
//

import Foundation
import Model
import Repository
import Common

@MainActor
public final class TagInformationViewModel: ObservableObject {

    let tag: ItemTag
    @Published var isFollowed: Bool = false

    private let tagRepository: TagRepository

    // MARK: - Initializer

    init(tag: ItemTag, tagRepository: TagRepository) {
        self.tag = tag
        self.tagRepository = tagRepository
    }

    // MARK: - Public

    func follow() async {
        isFollowed = true
        do {
            _ = try await tagRepository.follow(id: tag.id)
        } catch {
            isFollowed = false
            Logger.error(error)
        }
    }

    func unfollow() async {
        isFollowed = false
        do {
            _ = try await tagRepository.unfollow(id: tag.id)
        } catch {
            isFollowed = true
            Logger.error(error)
        }
    }

    func checkIsFollowed() async {
        do {
            _ = try await tagRepository.checkIsFollowed(id: tag.id)
            isFollowed = true
        } catch {
            isFollowed = false
            Logger.error(error)
        }
    }
}
