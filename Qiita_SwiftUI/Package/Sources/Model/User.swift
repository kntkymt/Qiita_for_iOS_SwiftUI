//
//  User.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

public struct User: Codable, Identifiable {

    public var id: String
    public var name: String
    public var description: String?
    public var profileImageUrl: URL
    public var itemsCount: Int
    public var followeesCount: Int
    public var followersCount: Int

    public init (id: String, name: String, description: String?, profileImageUrl: URL, itemsCount: Int, followeesCount: Int, followersCount: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.profileImageUrl = profileImageUrl
        self.itemsCount = itemsCount
        self.followeesCount = followeesCount
        self.followersCount = followersCount
    }
}
