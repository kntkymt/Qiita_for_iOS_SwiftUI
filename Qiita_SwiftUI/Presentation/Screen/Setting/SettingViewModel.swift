//
//  SettingViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/20.
//

import Foundation
import Combine

final class SettingViewModel: ObservableObject, Identifiable {

    // MARK: - Property

    private let authRepository: AuthRepository
    private var cancellables = [AnyCancellable]()

    // MARK: - Initializer

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    // MARK: - Public

    func logout(completion: @escaping () -> Void) {
        authRepository.signout()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    Logger.error(error)
                }
            }, receiveValue: { _ in
                completion()
            }).store(in: &cancellables)
    }
}

