//
//  TagInformationViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/09/13.
//

import Foundation
import Combine

final class TagInformationViewModel: ObservableObject {

    let tag: ItemTag
    @Published var isFollowed: Bool = false

    private let tagRepository: TagRepository
    private var cancellables = [AnyCancellable]()

    // MARK: - Initializer

    init(tag: ItemTag, tagRepository: TagRepository) {
        self.tag = tag
        self.tagRepository = tagRepository
    }

    // MARK: - Public

    func follow() {
        isFollowed = true
        tagRepository.follow(id: tag.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.isFollowed = false
                    Logger.error(error)
                }
            }, receiveValue: { _ in
            }).store(in: &cancellables)
    }

    func unfollow() {
        isFollowed = false
        tagRepository.unfollow(id: tag.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.isFollowed = true
                    Logger.error(error)
                }
            }, receiveValue: { _ in
            }).store(in: &cancellables)
    }

    func checkIsFollowed() {
        tagRepository.checkIsFollowed(id: tag.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.isFollowed = false
                    Logger.error(error)
                }
            }, receiveValue: { _ in
                self.isFollowed = true
            }).store(in: &cancellables)
    }
}
