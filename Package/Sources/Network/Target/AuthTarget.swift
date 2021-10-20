//
//  AuthTarget.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Moya
import Common

public enum AuthTarget {

    case getAccessToken(code: String)
    case deleteAccessToken(accessToken: String)
    case getAccount
}

// MARK: - BaseTarget

extension AuthTarget: BaseTarget {

    public var path: String {
        switch self {
        case .getAccessToken:
            return "/access_tokens"

        case .deleteAccessToken(let accessToken):
            return "/access_tokens/\(accessToken)"

        case .getAccount:
            return "/authenticated_user"
        }
    }

    public var method: Method {
        switch self {
        case .getAccessToken:
            return .post

        case .deleteAccessToken:
            return .delete

        case .getAccount:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .getAccessToken(let code):
            let parameters: Parameters = [
                "client_id": AppConstant.Auth.clientId,
                "client_secret": AppConstant.Auth.clientSecret,
                "code": code
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)

        case .deleteAccessToken:
            return .requestPlain

        case .getAccount:
            return .requestPlain
        }
    }
}
