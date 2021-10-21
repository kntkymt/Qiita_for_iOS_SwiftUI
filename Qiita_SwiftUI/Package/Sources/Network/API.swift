//
//  API.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Moya
import Foundation
import Model
import Common

public final class API {

    // MARK: - Static

    public static private(set) var shared: API!

    // MARK: - Property

    private let provider: MoyaProvider<MultiTarget>

    private let decoder: JSONDecoder = {        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return decoder
    }()

    // MARK: - Public

    public static func setup(provider: MoyaProvider<MultiTarget>) {
        self.shared = API(provider: provider)
    }

    public func call<T: Decodable, Target: TargetType>(_ request: Target) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            let target = MultiTarget(request)
            self.provider.request(target) { response in
                // 200番台以外をfailureにする
                let result = response.flatMap { old in
                    // swiftlint:disable:next force_cast
                    Swift.Result { try old.filterSuccessfulStatusCodes() }.mapError { $0 as! MoyaError }
                }

                switch result {
                case .success(let result):
                    do {
                        // FIXME: 204の扱い
                        if result.statusCode == 204 {
                            guard let decoded = VoidModel() as? T else {
                                continuation.resume(throwing: APIError.responseTypeDosentMatch)
                                return
                            }

                            continuation.resume(returning: decoded)
                        } else {
                            continuation.resume(returning: try self.decoder.decode(T.self, from: result.data))
                        }
                    } catch {
                        continuation.resume(throwing: APIError.decode(error))
                    }

                case .failure(let error):
                    continuation.resume(throwing: self.createError(from: error))

                }
            }
        }
    }

    // MARK: - Private

    private func createError(from error: MoyaError) -> Error {
        switch error {
        case .statusCode(let response):
            return APIError.statusCode(.init(statusCode: response.statusCode))
            
        case .underlying(let authError as AuthError, _):
            // AuthErrorはトップレベルエラーとして扱いたいのでそのまま返す
            return authError

        case .underlying(let underlyingError, _):
            // underlyingの場合は情報量がないので展開して返す
            return APIError.response(underlyingError)

        default:
            return APIError.response(error)
        }
    }

    // MARK: - Initializer

    private init(provider: MoyaProvider<MultiTarget>) {
        self.provider = provider
    }
}
