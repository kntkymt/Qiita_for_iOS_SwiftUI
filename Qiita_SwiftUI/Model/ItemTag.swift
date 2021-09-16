//
//  ItemTag.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

struct ItemTag: Codable, Identifiable {

    var iconUrl: URL?
    var followersCount: Int
    var id: String
    var itemsCount: Int
}
