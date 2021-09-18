//
//  FooterLoadingView.swift
//  Qiita_SwiftUI
//
//  Created by kntk on 2021/09/17.
//

import SwiftUI
import Introspect

private struct FooterLoadingView: UIViewRepresentable {

    // MARK: - Property

    @State private var observer: NSKeyValueObservation?

    let onReachBottom: () -> Void

    private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.style = .medium
        indicatorView.backgroundColor = .secondarySystemGroupedBackground

        indicatorView.color = .systemGray
        indicatorView.frame.size.height = 50
        indicatorView.isHidden = false
        return indicatorView
    }()

    // MARK: - Public

    public func makeUIView(context: UIViewRepresentableContext<FooterLoadingView>) -> UIView {
        let view = UIView(frame: .zero)
        view.isHidden = true
        view.isUserInteractionEnabled = false
        return view
    }

    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<FooterLoadingView>) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            guard let tableView = self.tableView(entry: uiView) else { return }

            tableView.tableFooterView = indicatorView

            // スクロール値を購読してonReachBottom判定
            observer = tableView.observe(\.contentOffset, changeHandler: { tableView, newValue in
                let visibleHeight = tableView.frame.height - tableView.contentInset.top - tableView.contentInset.bottom
                let y = tableView.contentOffset.y + tableView.contentInset.top
                let threshold = max(0.0, tableView.contentSize.height - visibleHeight)

                if y > threshold {
                    indicatorView.startAnimating()
                    onReachBottom()
                } else {
                    indicatorView.stopAnimating()
                }
            })
        }
    }

    // MARK: - Private

    private func tableView(entry: UIView) -> UITableView? {

        // Search in ancestors
        if let tableView = Introspect.findAncestor(ofType: UITableView.self, from: entry) {
            return tableView
        }

        guard let viewHost = Introspect.findViewHost(from: entry) else {
            return nil
        }

        // Search in siblings
        return Introspect.previousSibling(containing: UITableView.self, from: viewHost)
    }
}

extension View {
    public func footerLoading(onReachBottom: @escaping () -> Void) -> some View {
        return overlay(FooterLoadingView(onReachBottom: onReachBottom)
                        .frame(width: 0, height: 0))
    }
}
