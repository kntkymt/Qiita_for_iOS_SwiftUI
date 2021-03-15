//
//  Auth.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import SafariServices
import Foundation
import Combine

final class Auth {

    // MARK: - Static

    static let shared = Auth()

    // MARK: - Property

    private var resolver: ((Result<AuthModel, Error>) -> Void)!

    private lazy var viewController: SFSafariViewController = {
        let url = URL(string: AppConstant.Auth.baseURL)!
            .addQuery(name: "scope", value: AppConstant.Auth.scope)!
            .addQuery(name: "client_id", value: AppConstant.Auth.clientId)!

        let viewController = SFSafariViewController(url: url)
        viewController.modalPresentationStyle = .automatic

        return viewController
    }()

    @KeyChain(key: "accessToken")
    var accessToken: String?

    var isSignedin: Bool {
        return accessToken != nil
    }

    var currentUser: AnyPublisher<User, Error> {
        return API.shared.call(AuthTarget.getAccount).eraseToAnyPublisher()
    }

    // MARK: - Public

    func handleDeepLink(url: URL) {
//        viewController.bottomPresentingViewController().dismiss(animated: true)
//        let parameters = url.queryParameters
//        guard let code = parameters["code"] else {
//            observer.resolver.reject(NetworkingError.internal(message: "there is no parameter named code in this deeplink"))
//            return
//        }
//
//        API.shared.call(AuthTarget.getAccessToken(code: code))
//            .done { (auth: AuthModel) in
//                self.accessToken = auth.token
//                self.observer.resolver.fulfill(auth)
//            }.catch { error in
//                self.observer.resolver.reject(error)
//            }
    }

    func signin() -> AnyPublisher<AuthModel, Error> {
        return Future { resolver in
            self.resolver = resolver
        }.eraseToAnyPublisher()

//        SceneRouter.shared.rootViewController.currentViewController?.topPresentedViewController().present(viewController, animated: true)
    }

    func signout() -> AnyPublisher<Void, Error> {
        let result: Future<VoidModel, Error> = API.shared.call(AuthTarget.deleteAccessToken(accessToken: accessToken ?? "accessToken not found"))

        return result.map { _ in self.accessToken = nil }.eraseToAnyPublisher()
    }

    // MARK: - Initializer

    private init() {
    }
}
