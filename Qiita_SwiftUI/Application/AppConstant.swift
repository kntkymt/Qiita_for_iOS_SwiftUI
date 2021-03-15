//
//  AppConstant.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

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
    }
}
