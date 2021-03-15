//
//  API.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Moya
import Foundation
import Combine

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

   func call<T: Decodable, Target: TargetType>(_ request: Target) -> Future<T, Error> {
        let target = MultiTarget(request)
        return Future { resolver in
            self.provider.request(target) { response in
                switch response {
                case .success(let result):
                    do {
                        // FIXME: 204の扱い
                        if result.statusCode == 204 {
                            guard let decoded = VoidModel() as? T else { throw NetworkingError.network }
                            resolver(.success(decoded))
                        } else {
                            resolver(.success(try self.decoder.decode(T.self, from: result.data)))
                        }
                    } catch {
                        resolver(.failure(error))
                    }
                case .failure(let error):
                    resolver(.failure(NetworkingError(error: error)))
                }
            }
        }
    }

    // MARK: - Initializer

    private init() {
        provider = AppContainer.shared.apiProvider
    }
}
