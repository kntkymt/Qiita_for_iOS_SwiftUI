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
        setupLogger()

        return true
    }

    // MARK: - Private

    private func setupLogger() {
        Logger.setup()
        Logger.info("💫 Application will finish launching")
    }
}
