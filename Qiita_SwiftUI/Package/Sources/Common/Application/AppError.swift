//
//  AppError.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

public enum APIError: Error {

    public enum HTTPStatusCodeError: Error {
        /// 400
        case badrequest

        /// 401
        case unauthorized

        /// 403
        case forbidden

        /// 404
        case notfound

        /// 500番台
        case server(Int)

        /// 200番台以外かつ上記以外の番号
        case unknown(Int)

        // MARK: - Property

        /// NSErrorに変換した時のdomainを定義
        public var _domain: String {
            return "HTTPStatusCodeError"
        }

        /// NSErrorに変換した時のcodeを定義
        public var _code: Int {
            switch self {
            case .badrequest:
                return 400
            case .unauthorized:
                return 401
            case .forbidden:
                return 403
            case .notfound:
                return 404
            case .server(let statusCode):
                return statusCode
            case .unknown(let statusCode):
                return statusCode
            }
        }

        // MARK: - Initializer

        public init(statusCode: Int) {

            switch statusCode {
            case 400:
                self = .badrequest
            case 401:
                self = .unauthorized
            case 403:
                self = .forbidden
            case 404:
                self = .notfound
            case 500..<600:
                self = .server(statusCode)
            default:
                self = .unknown(statusCode)
            }
        }
    }

    /// 200番代以外のステータスコードが返ってきた場合
    case statusCode(HTTPStatusCodeError)

    /// レスポンスを受け取れなかった(ネットワーク不良など)
    case response(Error)

    /// レスポンスのパースに失敗した
    case decode(Error)

    /// レスポンスが予期した型ではない
    /// 204の場合にVoidModelではなかった時に利用
    case responseTypeDosentMatch

    public var causeError: Error? {
        switch self {
        case .statusCode(let statusCodeError):
            return statusCodeError

        case .decode(let error):
            return error

        case .response(let error):
            return error

        case .responseTypeDosentMatch:
            return nil
        }
    }
}

public enum AuthError: Error {

    /// レスポンスを受け取れなかった(ネットワーク不良など)
    case response(Error)

    /// ログインしているのにトークンがない
    case tokenNotFound

    /// Deeplinkの設定ミス
    case deeplink

    public var causeError: Error? {
        switch self {
        case .response(let error):
            return error

        case .tokenNotFound:
            return nil

        case .deeplink:
            return nil
        }
    }
}
