//
//  AppContainer.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation
import Moya
import Common
import Network

public final class AppContainer {

    // MARK: - Static

    public static let shared = AppContainer()

    // MARK: - Property

    public let repositoryContainer: RepositoryContainer
    public let apiProvider: MoyaProvider<MultiTarget>

    // MARK: - Private

    private init() {
        switch AppEnvironment.shared.buildConfig {
        case .debug, .release:

            repositoryContainer = RepositoryContainerFactory.createServices()
            apiProvider = APIProviderFactory.createDefault()
        }
    }
}
