//
//  Item.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

public struct Item: Codable, Identifiable {

    public var title: String
    public var id: String
    public var url: URL
    public var likesCount: Int
    public var createdAt: Date
    public var user: User

    public init(title: String, id: String, url: URL, likesCount: Int, createdAt: Date, user: User) {
        self.title = title
        self.id = id
        self.url = url
        self.likesCount = likesCount
        self.createdAt = createdAt
        self.user = user
    }
}
