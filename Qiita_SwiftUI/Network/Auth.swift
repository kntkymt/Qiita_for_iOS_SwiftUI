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

    @KeyChain(key: "accessToken")
    var accessToken: String?

    private var cancellables = [AnyCancellable]()

    var isSignedin: Bool {
        return accessToken != nil
    }

    var currentUser: AnyPublisher<User, Error> {
        return API.shared.call(AuthTarget.getAccount).eraseToAnyPublisher()
    }

    // MARK: - Public

    func handleDeepLink(url: URL) {
        let parameters = url.queryParameters
        guard let code = parameters["code"] else {
            resolver(.failure(NetworkingError.internal(message: "there is no parameter named code in this deeplink")))
            return
        }

        (API.shared.call(AuthTarget.getAccessToken(code: code)) as Future<AuthModel, Error>)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    Logger.error(error)
                    self.resolver(.failure(error))
                }
            }, receiveValue: { auth in
                self.accessToken = auth.token
                self.resolver(.success(auth))
            }).store(in: &cancellables)
    }

    func signin() -> AnyPublisher<AuthModel, Error> {
        return Future { resolver in
            self.resolver = resolver
        }.eraseToAnyPublisher()
    }

    func signout() -> AnyPublisher<Void, Error> {
        let result: Future<VoidModel, Error> = API.shared.call(AuthTarget.deleteAccessToken(accessToken: accessToken ?? "accessToken not found"))

        return result.map { _ in self.accessToken = nil }.eraseToAnyPublisher()
    }

    // MARK: - Initializer

    private init() {
    }
}
