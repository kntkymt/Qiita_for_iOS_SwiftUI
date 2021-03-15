//
//  Logger.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation
import SwiftyBeaver

typealias Logger = SwiftyBeaver

extension Logger {

    static func setup() {
        let destination = ConsoleDestination()
        SwiftyBeaver.addDestination(destination)
    }
}
