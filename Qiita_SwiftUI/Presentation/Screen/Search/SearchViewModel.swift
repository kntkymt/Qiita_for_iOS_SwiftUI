//
//  SearchViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/20.
//

import Foundation

@MainActor
final class SearchViewModel: ObservableObject {

    // MARK: - Property

    @Published var tags: [ItemTag] = []

    private let tagRepository: TagRepository

    // MARK: - Initializer

    init(tagRepository: TagRepository) {
        self.tagRepository = tagRepository
    }

    // MARK: - Public

    func fetchTags() async {
        do {
            tags = try await tagRepository.getTags(page: 1, perPage: 30, sort: "count")
        } catch {
            Logger.error(error)
        }
    }
}
