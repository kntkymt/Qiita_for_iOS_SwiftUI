//
//  API.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Moya
import Foundation

final class API {

    // MARK: - Static

    static let shared = API()

    // MARK: - Property

    private let provider: MoyaProvider<MultiTarget>

    private let decoder: JSONDecoder = {        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return decoder
    }()

    // MARK: - Public

    func call<T: Decodable, Target: TargetType>(_ request: Target) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            let target = MultiTarget(request)
            self.provider.request(target) { response in
                switch response {
                case .success(let result):
                    do {
                        // FIXME: 204の扱い
                        if result.statusCode == 204 {
                            guard let decoded = VoidModel() as? T else {
                                continuation.resume(throwing: NetworkingError.network)
                                return
                            }

                            continuation.resume(returning: decoded)
                        } else {
                            continuation.resume(returning: try self.decoder.decode(T.self, from: result.data))
                        }
                    } catch {
                        continuation.resume(throwing: error)
                    }

                case .failure(let error):
                    continuation.resume(throwing: NetworkingError(error: error))
                }
           }
       }
   }

    // MARK: - Initializer

    private init() {
        provider = AppContainer.shared.apiProvider
    }
}
