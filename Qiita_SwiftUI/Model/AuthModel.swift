//
//  AuthModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

struct AuthModel: Codable {

    var clientId: String
    var scopes: [String]
    var token: String
}
