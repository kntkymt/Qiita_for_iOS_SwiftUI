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

struct SafariView: UIViewControllerRepresentable {

    // MARK: - Property

    var url: URL

    // MARK: - Public

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }
}

