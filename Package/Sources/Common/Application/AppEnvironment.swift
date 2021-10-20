//
//  AppEnvironment.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

public enum BuildConfig {
    case debug
    case release
}

public final class AppEnvironment {

    // MARK: - Static

    public static let shared = AppEnvironment()

    // MARK: - Public

    public var buildConfig: BuildConfig {
        #if DEBUG
        return .debug
        #else
        return .release
        #endif
    }
}
