//
//  Qiita_SwiftUIApp.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import SwiftUI
import Presentation
import Common
import Repository
import Service
import Network

@main
struct Qiita_SwiftUIApp: App {

    private let repositoryContainer = RepositoryContainer(itemRepository: ItemService(), tagRepository: TagService(), stockRepository: StockService(), userRepository: UserService(), likeRepository: LikeService(), authRepository: AuthService())
    
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
        setupAPI()

        return true
    }

    // MARK: - Private

    private func setupConstant() {
        let env = readEnvironmentVariables()

        let link = AppConstant.Link(developer: "https://github.com/kntkymt",
                                    repository: "https://github.com/kntkymt/Qiita_for_iOS_SwiftUI")

        let domain = "qiita.com"
        let api = AppConstant.API(domain: domain,
                                  baseURL: "https://\(domain)/api/v2")

        let auth = AppConstant.Auth(baseURL: "\(api.baseURL)/oauth/authorize",
                                    scope: "read_qiita write_qiita",
                                    cliendId: env["QIITA_AUTH_CLIENT_ID"]!,
                                    clientSecret: env["QIITA_AUTH_CLIENT_SECRET"]!,
                                    keychainID: "kntk_qiita_swiftui")

        AppConstant.setup(constants: .init(link: link, api: api, auth: auth))
    }

    private func setupLogger() {
        Logger.setup()
        Logger.info("💫 Application will finish launching")
    }

    private func setupAPI() {
        API.setup(provider: APIProviderFactory.createDefault())
    }

    private func readEnvironmentVariables() -> [String: String] {
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
        return env
    }
}
