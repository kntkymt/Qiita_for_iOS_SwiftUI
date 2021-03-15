//
//  AuthState.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

final class AuthState: ObservableObject {

    @Published var isSignedin: Bool = false

    init(authRepository: AuthRepository) {
        isSignedin = authRepository.isSignedin
    }
}
