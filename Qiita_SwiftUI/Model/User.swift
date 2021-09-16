//
//  User.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

struct User: Codable, Identifiable {

    var id: String
    var name: String
    var description: String?
    var profileImageUrl: URL
    var itemsCount: Int
    var followeesCount: Int
    var followersCount: Int
}
