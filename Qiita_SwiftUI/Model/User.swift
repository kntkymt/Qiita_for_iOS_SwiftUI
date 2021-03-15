//
//  User.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

struct User: Codable, Identifiable {

    let id: String
    let name: String
    let description: String?
    let profileImageUrl: URL
    let itemsCount: Int
    let followeesCount: Int
    let followersCount: Int
}
