//
//  AuthTokenInterceptor.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation
import Moya
import Common

final class AuthTokenInterceptor: Interceptor {

    // MARK: - Public

    func intercept<T>(_ target: T.Type, endpoint: Endpoint, done: @escaping MoyaProvider<T>.RequestResultClosure) where T: TargetType {
        guard let request = try? endpoint.urlRequest() else {
            done(.failure(.requestMapping(endpoint.url)))
            return
        }

        guard let accessToken = Auth.shared.accessToken else {
            if Auth.shared.isSignedin {
                done(.failure(.underlying(AuthError.tokenNotFound, nil)))
            } else {
                // アクセストークン取得APIや認証なしAPIの場合
                done(.success(request))
            }
            return
        }

        done(.success(self.createRequest(with: accessToken, from: request)))
    }

    // MARK: - Private

    private func createRequest(with token: String, from request: URLRequest) -> URLRequest {
        var request = request
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
