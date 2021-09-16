//
//  Item.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

struct Item: Codable, Identifiable {

    var title: String
    var id: String
    var url: URL
    var likesCount: Int
    var createdAt: Date
    var user: User
}
