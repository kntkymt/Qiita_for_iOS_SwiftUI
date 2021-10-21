//
//  AppConstant.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

public enum AppConstant {

    public final class Constants {
        public let link: Link
        public let api: API
        public let auth: Auth

        public init(link: Link, api: API, auth: Auth) {
            self.link = link
            self.api = api
            self.auth = auth
        }
    }

    public final class Link {
        public let developer: String
        public let repository: String

        public init(developer: String, repository: String) {
            self.developer = developer
            self.repository = repository
        }
    }

    public final class API {
        public let domain: String
        public let baseURL: String

        public init(domain: String, baseURL: String) {
            self.domain = domain
            self.baseURL = baseURL
        }
    }

    public final class Auth {
        public let baseURL: String
        public let scope: String
        public let clientId: String
        public let clientSecret: String
        public let keychainID: String

        public var signinURL: URL {
            return URL(string: AppConstant.shared.auth.baseURL)!
                .addQuery(name: "scope", value: AppConstant.shared.auth.scope)!
                .addQuery(name: "client_id", value: AppConstant.shared.auth.clientId)!
        }

        public init(baseURL: String, scope: String, cliendId: String, clientSecret: String, keychainID: String) {
            self.baseURL = baseURL
            self.scope = scope
            self.clientId = cliendId
            self.clientSecret = clientSecret
            self.keychainID = keychainID
        }
    }

    // MARK: - Static

    public static private(set) var shared: Constants!

    // MARK: - Public

    public static func setup(constants: Constants) {
        shared = constants
    }
}
