//
//  APIProviderFactory.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Moya
import Alamofire
import Foundation

struct APIProviderFactory {

    // MARK: - Property

    private static let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        configuration.timeoutIntervalForRequest = 30

        return configuration
    }()

    // MARK: - Property

    static func createDefault() -> MoyaProvider<MultiTarget> {
        return createProvider(interceptores: [AuthTokenInterceptor()])
    }

    // MARK: - Private

    private static func createProvider(interceptores: [Interceptor], stubBehavior: @escaping (MultiTarget) -> StubBehavior = MoyaProvider.neverStub) -> MoyaProvider<MultiTarget> {

        let sessionManager = Session(configuration: configuration)

        // 各リクエストにトークンを付与
        let closure = { (endpoint: Endpoint, done: @escaping MoyaProvider.RequestResultClosure) in
            interceptores.forEach { interceptor in
                interceptor.intercept(MultiTarget.self, endpoint: endpoint, done: done)
            }
        }

        let provider = MoyaProvider<MultiTarget>(requestClosure: closure,
                                                 stubClosure: stubBehavior,
                                                 session: sessionManager,
                                                 plugins: [LoggerPlugin()])

        return provider
    }

    private init() {
    }
}
