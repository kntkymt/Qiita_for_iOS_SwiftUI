//
//  AppEnvironment.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

enum BuildConfig {
    case debug
    case release
}

final class AppEnvironment {

    // MARK: - Static

    static let shared = AppEnvironment()

    // MARK: - Public

    var buildConfig: BuildConfig {
        #if DEBUG
        return .debug
        #else
        return .release
        #endif
    }
}
