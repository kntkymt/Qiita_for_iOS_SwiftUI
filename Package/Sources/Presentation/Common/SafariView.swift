//
//  SafariView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/03/15.
//

import Foundation
import SafariServices
import UIKit
import SwiftUI

public struct SafariView: UIViewControllerRepresentable {

    // MARK: - Property

    var url: URL

    // MARK: - Public

    public func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    public func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }
}

