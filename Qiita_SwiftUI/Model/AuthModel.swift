//
//  AuthModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

struct AuthModel: Codable {

    let clientId: String
    let scopes: [String]
    let token: String
}
