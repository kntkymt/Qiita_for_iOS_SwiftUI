//
//  LoggerPlugin.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Moya

struct LoggerPlugin: PluginType {

    func willSend(_ request: RequestType, target: TargetType) {
        request.request.map { Logger.debug($0.curlString) }
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        Logger.debug(result)
    }
}
