//
//  APITargetType.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Moya
import Foundation

protocol BaseTarget: TargetType {
}

extension BaseTarget {

    var baseURL: URL {
        return URL(string: AppConstant.API.baseURL)!
    }

    var headers: [String: String]? {
        return [:]
    }

    var validationType: ValidationType {
        return .successCodes
    }

    var sampleData: Data {
        return Data()
    }
}

typealias Parameters = [String: Any]
