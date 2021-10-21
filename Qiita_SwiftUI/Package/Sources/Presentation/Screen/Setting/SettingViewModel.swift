//
//  SettingViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/20.
//

import Foundation
import Repository
import Common

@MainActor
public final class SettingViewModel: ObservableObject, Identifiable {

    // MARK: - Property

    private let authRepository: AuthRepository

    // MARK: - Initializer

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    // MARK: - Public

    func logout(completion: @escaping () -> Void) async {
        do {
            try await authRepository.signout()
            completion()
        } catch {
            Logger.error(error)
        }
    }
}

