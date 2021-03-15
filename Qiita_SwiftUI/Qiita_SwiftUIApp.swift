//
//  Qiita_SwiftUIApp.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import SwiftUI

@main
struct Qiita_SwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            LaunchView(authRepository: AuthStubService())
                .environmentObject(AuthState(authRepository: AuthStubService()))
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

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
