//
//  WebView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/05/15.
//

import SwiftUI
import WebKit
import Common

public struct WebView: UIViewRepresentable {

    // MARK: - Property

    private let sharedConfig: WKWebViewConfiguration = {
        let userContentController = WKUserContentController()
        let fileName = "WebViewRuleList.json"

        if let jsonFilePath = Bundle.main.path(forResource: fileName, ofType: nil),
            let jsonFileContent = try? String(contentsOfFile: jsonFilePath, encoding: String.Encoding.utf8) {
            WKContentRuleListStore.default().compileContentRuleList(forIdentifier: "qiita", encodedContentRuleList: jsonFileContent) { contentRuleList, error in
                if let error = error {
                    Logger.error(error)
                    return
                }
                if let list = contentRuleList {
                    userContentController.add(list)
                }
            }
        }

        let config = WKWebViewConfiguration()
        config.userContentController = userContentController
        config.websiteDataStore = .default()

        return config
    }()

    var url: URL

    // MARK: - Public

    public func makeUIView(context: Context) -> WKWebView {
        return WKWebView(frame: .zero, configuration: sharedConfig)
    }

    public func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}
