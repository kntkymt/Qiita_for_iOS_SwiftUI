//
//  APITargetType.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Moya
import Foundation
import Common

protocol BaseTarget: TargetType {
}

extension BaseTarget {

    public var baseURL: URL {
        return URL(string: AppConstant.API.baseURL)!
    }

    public var headers: [String: String]? {
        return [:]
    }

    public var validationType: ValidationType {
        return .successCodes
    }

    public var sampleData: Data {
        return Data()
    }
}

typealias Parameters = [String: Any]
