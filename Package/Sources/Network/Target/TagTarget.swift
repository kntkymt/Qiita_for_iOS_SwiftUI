//
//  TagTarget.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Moya
import Model

public enum TagTarget {

    case getTags(page: Int, perPage: Int, sort: String)
    case getItems(page: Int, id: ItemTag.ID)
    case follow(id: ItemTag.ID)
    case unfollow(id: ItemTag.ID)
    case checkIsFollowed(id: ItemTag.ID)
}

// MARK: - BaseTarget

extension TagTarget: BaseTarget {

    public var path: String {
        switch self {
        case .getTags:
            return "/tags"

        case .getItems(let param):
            return "/tags/\(param.id)/items"

        case .follow(let id):
            return "tags/\(id)/following"

        case .unfollow(let id):
            return "tags/\(id)/following"

        case .checkIsFollowed(let id):
            return "tags/\(id)/following"
        }
    }

    public var method: Method {
        switch self {
        case .getTags:
            return .get

        case .getItems:
            return .get

        case .follow:
            return .put

        case .unfollow:
            return .delete

        case .checkIsFollowed:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .getTags(let page, let perPage, let sort):
            let parameters: Parameters = [
                "page": page,
                "per_page": perPage,
                "sort": sort
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)

        case .getItems(let page, _):
            let parameters: Parameters = [
                "page": page
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)

        case .follow:
            return .requestPlain

        case .unfollow:
            return .requestPlain

        case .checkIsFollowed:
            return .requestPlain
        }
    }
}
