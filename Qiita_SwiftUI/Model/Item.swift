//
//  Item.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

struct Item: Codable, Identifiable {

    let title: String
    let id: String
    let url: URL
    let likesCount: Int
    let createdAt: Date
    let user: User
}
