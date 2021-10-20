//
//  ItemTag.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

public struct ItemTag: Codable, Identifiable {

    public var iconUrl: URL?
    public var followersCount: Int
    public var id: String
    public var itemsCount: Int

    public init(iconUrl: URL?, followersCount: Int, id: String, itemsCount: Int) {
        self.iconUrl = iconUrl
        self.followersCount = followersCount
        self.id = id
        self.itemsCount = itemsCount
    }
}
