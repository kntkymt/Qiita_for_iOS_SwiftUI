//
//  ItemTag.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation

struct ItemTag: Codable, Identifiable {

    let iconUrl: URL?
    let followersCount: Int
    let id: String
    let itemsCount: Int
}
