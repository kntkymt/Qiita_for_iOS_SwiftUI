//
//  AppConstant.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

enum AppConstant {

    enum API {
        static let domain = "qiita.com"
        static let baseURL = "https://\(domain)/api/v2"
    }

    enum Auth {
        static let baseURL = "\(API.baseURL)/oauth/authorize"
        static let scope = "read_qiita write_qiita"
        static var clientId = ""
        static var clientSecret = ""
        static let keychainID = "kntk_qiita_swiftui"

        static var signinURL: URL {
            return URL(string: AppConstant.Auth.baseURL)!
                .addQuery(name: "scope", value: AppConstant.Auth.scope)!
                .addQuery(name: "client_id", value: AppConstant.Auth.clientId)!
        }
    }
}
