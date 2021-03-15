//
//  LoginViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation
import SwiftUI
import Combine

final class LoginViewModel: ObservableObject, Identifiable {

    // MARK: - Property

    private let authRepository: AuthRepository
    private var cancellables = [AnyCancellable]()

    // MARK: - Initializer

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    // MARK: - Public

    func login(success: @escaping () -> Void) {
        authRepository.signin()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    Logger.error(error)
                }
            }, receiveValue: { _ in
                success()
            }).store(in: &cancellables)
    }
}
