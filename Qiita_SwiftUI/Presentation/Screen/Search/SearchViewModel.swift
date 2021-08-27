//
//  SearchViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/20.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {

    // MARK: - Property

    @Published var tags: [ItemTag] = []

    private let tagRepository: TagRepository
    private var cancellables = [AnyCancellable]()

    // MARK: - Initializer

    init(tagRepository: TagRepository) {
        self.tagRepository = tagRepository

        fetchTags()
    }

    // MARK: - Public

    func fetchTags() {
        tagRepository.getTags(page: 1, perPage: 30, sort: "count")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    Logger.error(error)
                }
            }, receiveValue: { tags in
                self.tags = tags
            }).store(in: &cancellables)
    }
}
