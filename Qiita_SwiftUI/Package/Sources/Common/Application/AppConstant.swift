//
//  AppConstant.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

public enum AppConstant {

    public enum Link {
        public static let developer = "https://github.com/kntkymt"
        public static let repository = "https://github.com/kntkymt/Qiita_for_iOS_SwiftUI"
    }

    public enum API {
        public static let domain = "qiita.com"
        public static let baseURL = "https://\(domain)/api/v2"
    }

    public enum Auth {
        public static let baseURL = "\(API.baseURL)/oauth/authorize"
        public static let scope = "read_qiita write_qiita"
        public static var clientId = ""
        public static var clientSecret = ""
        public static let keychainID = "kntk_qiita_swiftui"

        public static var signinURL: URL {
            return URL(string: AppConstant.Auth.baseURL)!
                .addQuery(name: "scope", value: AppConstant.Auth.scope)!
                .addQuery(name: "client_id", value: AppConstant.Auth.clientId)!
        }
    }
}
