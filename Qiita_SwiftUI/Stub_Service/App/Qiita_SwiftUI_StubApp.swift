//
//  Qiita_SwiftUI_StubApp.swift
//  Qiita_SwiftUI_Stub
//
//  Created by kntk on 2021/10/21.
//

import SwiftUI
import Presentation
import Repository
import StubService
import Common

@main
struct Qiita_SwiftUI_StubApp: App {
    private let repositoryContainer = RepositoryContainer(itemRepository: ItemStubService(), tagRepository: TagStubService(), stockRepository: StockStubService(), userRepository: UserStubService(), likeRepository: LikeStubService(), authRepository: AuthStubService())

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(repositoryContainer)
                .environmentObject(AuthState(authRepository: repositoryContainer.authRepository))
        }
    }
}

final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        setupConstant()
        setupLogger()

        return true
    }

    // MARK: - Private

    private func setupConstant() {
        let link = AppConstant.Link(developer: "https://github.com/kntkymt",
                                    repository: "https://github.com/kntkymt/Qiita_for_iOS_SwiftUI")

        let domain = "qiita.com"
        let api = AppConstant.API(domain: domain,
                                  baseURL: "https://\(domain)/api/v2")

        let auth = AppConstant.Auth(baseURL: "\(api.baseURL)/oauth/authorize",
                                    scope: "",
                                    cliendId: "",
                                    clientSecret: "",
                                    keychainID: "kntk_qiita_swiftui")

        AppConstant.setup(constants: .init(link: link, api: api, auth: auth))
    }

    private func setupLogger() {
        Logger.setup()
        Logger.info("💫 Application will finish launching")
    }
}
