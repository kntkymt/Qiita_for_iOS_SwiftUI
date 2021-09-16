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
            LaunchView()
                .environmentObject(AppContainer.shared.repositoryContainer)
                .environmentObject(AuthState(authRepository: AppContainer.shared.repositoryContainer.authRepository))
        }
    }
}

final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        setupLogger()
        readEnvironmentVariables()

        return true
    }

    // MARK: - Private

    private func setupLogger() {
        Logger.setup()
        Logger.info("💫 Application will finish launching")
    }

    private func readEnvironmentVariables() {
        guard let path = Bundle.main.path(forResource: ".env", ofType: nil) else {
            fatalError("Not found: 'Qiita_SwiftUI/Configuration/.env'.\nPlease create .env file reference from .env.sample")
        }

        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let str = String(data: data, encoding: .utf8) ?? "Empty File"
            let clean = str.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "'", with: "")
            let envVars = clean.components(separatedBy: "\n")
            for envVar in envVars {
                let keyVal = envVar.components(separatedBy: "=")
                if keyVal.count == 2 {
                    setenv(keyVal[0], keyVal[1], 1)
                }
            }
        } catch {
            fatalError(error.localizedDescription)
        }

        let env = ProcessInfo.processInfo.environment
        AppConstant.Auth.clientId = env["QIITA_AUTH_CLIENT_ID"]!
        AppConstant.Auth.clientSecret = env["QIITA_AUTH_CLIENT_SECRET"]!
    }
}
