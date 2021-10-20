//
//  Logger.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation
import SwiftyBeaver

public typealias Logger = SwiftyBeaver

public extension Logger {

    static func setup() {
        let destination = ConsoleDestination()
        SwiftyBeaver.addDestination(destination)
    }
}
