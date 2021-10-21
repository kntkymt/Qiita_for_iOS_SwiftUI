//
//  AuthState.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation
import Repository

public final class AuthState: ObservableObject {

    @Published var isSignedin: Bool = false

    public init(authRepository: AuthRepository) {
        isSignedin = authRepository.isSignedin
    }
}
