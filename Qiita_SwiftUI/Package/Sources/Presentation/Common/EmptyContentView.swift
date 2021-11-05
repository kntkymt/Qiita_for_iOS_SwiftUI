//
//  EmptyContentView.swift
//  
//
//  Created by kntk on 2021/11/05.
//

import SwiftUI

public struct EmptyContentView: View {

    // MARK: - Property

    var title: String

    // MARK: - Public

    public var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 18, weight: .medium))
        }
    }
}
