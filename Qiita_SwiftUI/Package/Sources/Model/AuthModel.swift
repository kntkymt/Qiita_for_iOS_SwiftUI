//
//  AuthModel.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

public struct AuthModel: Codable {

    public var clientId: String
    public var scopes: [String]
    public var token: String

    public init(clientId: String, scopes: [String], token: String) {
        self.clientId = clientId
        self.scopes = scopes
        self.token = token
    }
}
