//
//  AppContainer.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation
import Moya

final class AppContainer {

    // MARK: - Static

    static let shared = AppContainer()

    // MARK: - Property

    let repositoryContainer: RepositoryContainer
    let apiProvider: MoyaProvider<MultiTarget>

    // MARK: - Private

    private init() {
        switch AppEnvironment.shared.buildConfig {
        case .debug, .release:

            repositoryContainer = RepositoryContainerFactory.createServices()
            apiProvider = APIProviderFactory.createDefault()
        }
    }
}
