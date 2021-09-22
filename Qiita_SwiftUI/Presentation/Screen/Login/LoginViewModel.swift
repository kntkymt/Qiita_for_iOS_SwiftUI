//
//  LoginViewModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation
import SwiftUI

@MainActor
final class LoginViewModel: ObservableObject, Identifiable {

    // MARK: - Property

    private let authRepository: AuthRepository

    // MARK: - Initializer

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    // MARK: - Public

    func login(success: @escaping () -> Void) async {
        do {
            _ = try await authRepository.signin()
            success()
        } catch {
            Logger.error(error)
        }
    }

    func handleDeepLink(url: URL) {
        authRepository.handleDeepLink(url: url)
    }
}
